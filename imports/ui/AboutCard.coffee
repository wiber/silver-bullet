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
{bulletUnitContainer} = require '../../imports/api/bulletUnit.coffee'

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
              # we need to assemble the data struc
              # what's needed for a card
              # url, title
              # and the votes that go on a link
              # face, profile, blurb, direction
              #
              # cycle through in links... render them and related out links
              # we are interested in what people are linking 'sending' to this place
              # can we make it less abstract? is the bidirectional association necessary?
              # how much power do we gain by weight, and direct
              if that.props.node?.in?
                k.build GridList,
                  class: 'looplist'
                  cols: 1
                  ->
                    # conditionals are ok, but we should move out data processing into pure functions with wallaby tests
                    # end result is a modular and clean way to render urls and votes
                    # from to header, list of comments with face votes..
                    # TODO reduce size of loops,
                    # for each url, paint header, paint each vote
                    # how much do we gain by pre forming object in this composer?
                    # can we rethink this as seeing one kind at a time from dropdown or will that break that aboutness feel we want?
                    #
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
                      U = {} # users votes loop object
                      U.D = D
                      U.usersConnections = N.inLinks[D.link]
                      k.build UrlTile,
                        keyD: timeLink+'Node'
                        title: D.m.title
                        subtitle: D.m.ToLink
                        node: that.props.node
                        ScreenshotUrl: D.m.ScreenshotUrl
                        ScreenshotUrlTo: D.m.ScreenshotUrlTo
                        FromLink: D.m.FromLink
                      k.build UrlBox,
                        D: D
                        N: N
                        U: U
                        from: that.props.from
                        to: that.props.to
                        props: that.props
                        ->
                          k.img
                            style: _.extend {}, style.webShot,
                              width: '100%'
                            src: D.m.ScreenshotUrl
                            from: D.m.FromLink
                            onClick: (e) ->
                             changeQueryParams 'from', e.target.getAttribute('from')
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
                                console.log that.props.from == V.vote.meta.FromLink
                                , that.props.from, ', that.props.from'
                                , that.props.from is V.vote.meta.ToLink
                                , V.vote.meta.ToLink,', V.vote.meta.ToLink'
                                , V.vote.meta.FromLink, ', V.vote.meta.FromLink'
                                , V.vote
                                , V.vote.meta.body?
                                , V.vote.meta.body
                                , 'console.log that.props.from, V.vote'
                                , that.props.from == V.vote.meta.ToLink, 'that.props.from == V.vote.meta.ToLink'
                                k.build LinkVote,
                                  from: that.props.from
                                  V: V
                              V.counted++
                      #if N.inLinks[timeLink]?
                      #  console.log 'incomming link by', Object.keys(N.inLinks[timeLink]) , D.firstUsersLink
                    console.log N

UrlBox = React.createClass
  propTypes:
    D: React.PropTypes.object
  render: ->
    that = this
    console.log that.props, 'sent to UrlBox'
    reactKup (k) ->
      D = that.props.D
      N = that.props.N
      U = that.props.U
      k.build GridTile,
        key: D.link+'Node'
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
                console.log that.props.from == V.vote.meta.FromLink
                , that.props.from, ', that.props.from'
                , that.props.from is V.vote.meta.ToLink
                , V.vote.meta.ToLink,', V.vote.meta.ToLink'
                , V.vote.meta.FromLink, ', V.vote.meta.FromLink'
                , V.vote
                , V.vote.meta.body?
                , V.vote.meta.body
                , 'console.log that.props.from, V.vote'
                , that.props.from == V.vote.meta.ToLink, 'that.props.from == V.vote.meta.ToLink'
                k.build LinkVote,
                  from: that.props.from
                  V: V
UrlTile = React.createClass
  propTypes:
    keyD: React.PropTypes.string
    title: React.PropTypes.string
    subtitle: React.PropTypes.string
    #ScreenshotUrl: React.propTypes.string
    #FromLink: React.propTypes.string
  render: ->
    that = this
    console.log that.props, 'sent to UrlTile'
    reactKup (k) ->
      key = that.props.keyD
      title = that.props.title
      subtitle = that.props.subtitle
      k.build GridTile,
        key: key
        title: title #that.props.node.meta.title
        ->
          k.img
            style: _.extend {}, style.webShot,
              width: '100%'
            src: that.props.ScreenshotUrl
            from: that.props.FromLink
            onClick: (e) ->
             changeQueryParams 'from', e.target.getAttribute('from')

LinkVote = React.createClass
  propTypes:
    linkVote: React.PropTypes.object
    V: React.PropTypes.object
  render: ->
    that = this
    console.log that.props, 'sent to linkVote'
    reactKup (k) ->
      V = that.props.V
      if that.props.from is V.vote.meta.FromLink
        bullet = '0 50% 50% 0'
      else
        bullet = '0 50% 50% 0'
      k.div ->
        k.span
          style:
            top: (V.counted + 0.25) * (V.size / 5)
            width: '100%' # 'auto'#
            left: 10
            color: 'rgb(255, 255, 255)'
            fontSize: '16px'
            position: 'absolute'
            backgroundColor: 'rgba(0, 0, 0, 0.2)'
          V.vote.meta.body
        k.a
          href: V.vote.meta.profileLink
          target: '_blank'
          k.img
            style: _.extend {},# style.webShot,
              top: V.counted *(V.size / 5)
              #width: '10%' #style.scalars.screenshotWidth / 10
              left: 10 * V.vote.meta.weight + '%'
              position: 'absolute'
              opacity: .5
              borderRadius: bullet # '0 50% 50% 0'
            src: V.vote.meta.face

preParseNode = (N) ->
  console.log N


exports.AboutCard = createContainer ((props) ->
  newProps = {}
  if props.from?
    Meteor.subscribe "Node", props.from
  N = Nodes.findOne(linkstate.store props.from)
  if N?
    newProps.node = N
    newProps.P = preParseNode N
  #console.log newProps.node, Nodes.find({}).count()
  props = _.extend {}, props, newProps
  props
), AboutCard
