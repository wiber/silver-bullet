# renders the aboutness node from here
reactKup = require('react-kup')
React = require('react')
{style} = require('../ui/style.coffee')
{changeQueryParams} = require('../api/changeQueryParams.coffee')
{FromToSense} = require('../ui/FromToSense.coffee')
Card = require('material-ui/lib/card/card').default
CardActions = require('material-ui/lib/card/card-actions' ).default
CardHeader = require('material-ui/lib/card/card-header').default
CardMedia = require('material-ui/lib/card/card-media').default
CardTitle = require('material-ui/lib/card/card-title').default
FlatButton = require('material-ui/lib/flat-button' ).default
CardText =  require('material-ui/lib/card/card-text').default
{GridList, GridTile} = require 'material-ui/lib/grid-list'
{Subheader} = require 'material-ui/lib/Subheader'
{StarBorder} = require 'material-ui/lib/svg-icons/toggle/star-border'

{createContainer} = require 'meteor/react-meteor-data'
{see, store} = require '../api/strings.coffee'
AboutCard = React.createClass
  render: ->
    that = this
    reactKup (k) ->
      k.build Card,
        expanded: that.props.expanded
        style: _.extend {}, style.card, style.mAcard
        ->
          k.build CardHeader,
            title: that.props.word.AboutCardTitle
            showExpandableButton: true
            subtitle: that.props.word.AboutCardSubTitle
            onClick: that.handleToggle
          k.build CardText,
            style:
              height: 'auto'
          k.build CardText,
            expandable: true
            ->
              # cycle through in links... render them and related out links
              # we are interested in what people are linking 'sending' to this place
              # can we make it less abstract? is the bidirectional association necessary?
              # how much power do we gain by weight, and direct
              if that.props.node?.in?
                k.build GridList,
                  class: 'looplist'
                  cols: 1
                  ->
                    N = {} # the node we're on
                    N.node = that.props.node

                    N.inLinks = that.props.node.in
                    N.outLinks = that.props.node.out
                    N.allLinks = _.extend {}, N.inLinks, N.outLinks

                    N.linksByTime = linkstate.sortByKeysTime(N.allLinks, that.props.howMany)
                    N.linkSort = {}
                    for link in Object.keys(N.allLinks)
                      N.sorts = linkstate.sortByKeysTime(N.allLinks[link],3)
                      N.recent = N.sorts[0]
                      N.linkSort[link] = N.allLinks[link][N.recent]
                    N.sortedLinks = linkstate.sortByKeysTime N.linkSort, that.props.howMany

                    for timeLink in N.sortedLinks
                      D = {} # this link which has many users votes
                      D.N = N
                      D.link = timeLink
                      D.users = N.allLinks[timeLink]
                      D.firstUsersLink = D.users[Object.keys(D.users)[0]]
                      D.m = D.firstUsersLink.meta
                      console.log D
                      k.build GridTile,
                        key: timeLink+'Node'
                        title: D.m.title
                        subtitle: D.m.ToLink
                        ->
                          k.img
                            style: _.extend {}, style.webShot,
                              width: '100%'
                            src: D.m.ScreenshotUrl
                            from: D.m.FromLink
                            onClick: (e) ->
                             changeQueryParams 'from', e.target.getAttribute('from')
                          U = {} # users votes loop object
                          U.D = D
                          U.usersConnections = N.inLinks[D.link]
                          if N.inLinks?[D.link]?
                            U.linksByTimeUsers = linkstate.sortByKeysTime(U.usersConnections)
                            console.log U
                            V = {}
                            V.U = U
                            V.counted = 0
                            for user in U.linksByTimeUsers
                              V.user = user
                              console.log V
                              V.vote = U.usersConnections[V.user]
                              V.size = size = style.scalars.screenshotWidth
                              console.log V
                              if V.vote?.meta?
                                k.span
                                  style:
                                    top: (V.counted + 0.25) * (V.size / 5)
                                    position: 'absolute'
                                  V.vote.meta.body
                                k.a
                                  href: V.vote.meta.profileLink
                                  target: '_blank'
                                  k.img
                                    style: _.extend {},# style.webShot,
                                      top: V.counted *(V.size / 5)
                                      width: '10%' #style.scalars.screenshotWidth / 10
                                      left: 10 * V.vote.meta.weight + '%'
                                      position: 'absolute'
                                      opacity: .5
                                      borderRadius: '50%'
                                    src: V.vote.meta.face
                                  # clicking on one should move to /user on facebook
                              V.counted++
                      #if N.inLinks[timeLink]?
                      #  console.log 'incomming link by', Object.keys(N.inLinks[timeLink]) , D.firstUsersLink
                    console.log N
UrlTile = React.createClass
  propTypes:
    node: React.PropTypes.object
    linkVotes: React.PropTypes.object
    title: React.PropTypes.string
  render: ->
    that = this
    console.log that.props, 'sent to UrlTile'
    reactKup (k) ->
      k.build GridTile,
        key: timeLink+'Node'
        title: that.props.node.meta.title
        ->
          k.img
            style: _.extend {}, style.webShot,
              width: '100%'
            src: that.props.node.meta.ScreenshotUrl
            from: that.props.node.meta.FromLink
            onClick: (e) ->
             changeQueryParams 'from', e.target.getAttribute('from')
          _.each that.props.linkVotes, LinkVote

LinkVote = React.createClass
  propTypes:
    linkVote: React.PropTypes.object
  render: ->
    that = this
    console.log that.props, 'sent to linkVote'
    reactKup (k) ->
      k.img
        style: _.extend {},# style.webShot,
          left: 10 * that.props.weight + '%'
          position: 'absolute'
          opacity: 1
          borderRadius: '50%'
        src: that.props.face
exports.AboutCard = createContainer ((props) ->
  newProps = {}
  if props.from?
    Meteor.subscribe "Node", props.from
  N = Nodes.findOne(linkstate.store props.from)
  if N?
    newProps.node = N
  #console.log newProps.node, Nodes.find({}).count()
  props = _.extend {}, props, newProps
  props
), AboutCard
