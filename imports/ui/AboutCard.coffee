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
                    for timeLink in N.linksByTime
                      D = {} # this link which has many users votes
                      D.link = timeLink
                      D.users = N.allLinks[timeLink]
                      D.firstUsersLink = D.users[Object.keys(D.users)[0]]
                      D.m = D.firstUsersLink.meta
                      console.log D
                      k.build GridTile,
                        key: timeLink+'Node'
                        title: D.m.FromLink
                        ->
                          U = {} # users votes loop object
                          U.usersConnections = N.inLinks[D.link]

                          if N.inLinks?[D.link]?
                            U.linksByTimeUsers = linkstate.sortByKeysTime(U.usersConnections)
                            console.log U
                            V = {}
                            V.counted = 0
                            for user in U.linksByTimeUsers
                              V.user = user

                              V.vote = D.users[V.user]
                              V.size = size = style.scalars.screenshotWidth
                              console.log V
                              if V.vote.meta?
                                k.span
                                  style:
                                    top: (V.counted + 0.25) * (V.size / 5)
                                    position: 'absolute'
                                  V.vote.meta.body
                                k.img
                                  style: _.extend {},# style.webShot,
                                    top: V.counted *(V.size / 5)
                                    width: '10%' #style.scalars.screenshotWidth / 10
                                    left: 10 * V.vote.meta.weight + '%'
                                    position: 'absolute'
                                    opacity: 1
                                    borderRadius: '50%'
                                  src: V.vote.meta.face
                              V.counted++
                      #if N.inLinks[timeLink]?
                      #  console.log 'incomming link by', Object.keys(N.inLinks[timeLink]) , D.firstUsersLink
                    console.log N

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


###
U = {}
U.usersConnections = N.inLinks[link]
# assume that first element has the correct title
# TODO rewrite
U.currentTitle = U.usersConnections[Object.keys(U.usersConnections)[0]].meta.title
U.linksByTimeUsers = linkstate.sortByKeysTime(U.usersConnections)
U.origin = link
[U.firstUser, ... , U.lastUser] = U.linksByTimeUsers
[U.firstLink, ... , U.lastLink] = N.linksByTime
console.log U, 'Users node'
vote = U.usersConnections[user]
console.log vote#, U.usersConnections
size = style.scalars.screenshotWidth
if vote.meta?
  k.span
    style:
      top: (counted + 0.25) * (size / 5)
      position: 'absolute'
    vote.meta.body
  k.img
    style: _.extend {},# style.webShot,
      top: counted *(size / 5)
      width: '10%' #style.scalars.screenshotWidth / 10
      left: 10 * vote.meta.weight + '%'
      position: 'absolute'
      opacity: 1
      borderRadius: '50%'
    src: vote.meta.face
  counted++
  ###
###
  for link in N.linksByTime
    console.log link, N.allLinks[link]
    if N.inLinks[link]?
      U = {}
      U.usersConnections = N.inLinks[link]
      # assume that first element has the correct title
      # TODO rewrite
      U.currentTitle = U.usersConnections[Object.keys(U.usersConnections)[0]].meta.title
      U.linksByTimeUsers = linkstate.sortByKeysTime(U.usersConnections)
      U.origin = link
      [U.firstUser, ... , U.lastUser] = U.linksByTimeUsers
      [U.firstLink, ... , U.lastLink] = N.linksByTime
      console.log U, 'Users node'
      k.build GridTile,
        key: link+'Node'
        title: U.currentTitle #m.body #target.title#FromLink
        subtitle: U.origin
        ->
          counted = 0
          for user in U.linksByTimeUsers
            vote = U.usersConnections[user]
            console.log vote#, U.usersConnections
            size = style.scalars.screenshotWidth
            if vote.meta?
              k.span
                style:
                  top: (counted + 0.25) * (size / 5)
                  position: 'absolute'
                vote.meta.body
              k.img
                style: _.extend {},# style.webShot,
                  top: counted *(size / 5)
                  width: '10%' #style.scalars.screenshotWidth / 10
                  left: 10 * vote.meta.weight + '%'
                  position: 'absolute'
                  opacity: 1
                  borderRadius: '50%'
                src: vote.meta.face
              counted++
          k.span ''#U.currentTitle
      n= 0
      for key, node of that.props.node.in
        #console.log key, node
        if that.props.node.out? and that.props.node.out[key]
          #console.log 'reciprical link', key # that.props.node.out[key],
          n++ ###
