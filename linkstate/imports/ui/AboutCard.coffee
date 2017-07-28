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
{UrlBox} = require '../../imports/ui/UrlBox.coffee'
R = require 'ramda'
{createContainer} = require 'meteor/react-meteor-data'
{see, store, AByMomentum, listByMomentum} = require '../api/strings.coffee'
n = 0
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
            onClick: (e) ->
              changeQueryParams 'expandAboutCard', !that.props.expande
          k.build CardText,
            style:
              height: 'auto'
          k.div
            style:
              display: 'inline'
              #flexWrap: 'wrap'
            -># CardText,
              # build in and out links.. so that we see our out connection right away
              if that.props.node?.in? or that.props.node?.out?
                k.build GridList,
                  class: 'looplist'
                  cellHeight: 500
                  cols: 1
                  ->
                    N = {} # the node we're on
                    N.node = that.props.node
                    N.inLinks = that.props.node.in
                    N.outLinks = that.props.node.out
                    N.link = N.node.link
                    console.log that.props.node
                    N.allLinks = _.extend {}, N.inLinks, N.outLinks

                    N.linksByTime = linkstate.sortByKeysTime(N.allLinks
                    , that.props.howMany)
                    N.linkSort = {}
                    for link in Object.keys(N.allLinks)
                      N.sorts = linkstate.sortByKeysTime(N.allLinks[link],3)
                      N.recent = N.sorts[0]
                      N.linkSort[link] = N.allLinks[link][N.recent]
                    #calculate momentum of a url by walking through voters on it
                    N.momentum = {}
                    N.vectors = {}
                    N.sortByWeight = AByMomentum N.inLinks
                    N.sortOutByWeight = AByMomentum N.outLinks
                    N.rankedinLinks = AByMomentum( N.inLinks)
                    N.rankedOutlinks = AByMomentum(N.outLinks)
                    N.sortAllMomentum = listByMomentum(N.rankedinLinks
                    , N.rankedOutlinks)
                    draw = 0
                    N.UrlBoxDraw = {}
                    console.log N
                    for linkByMomentum in listByMomentum(AByMomentum(N.node.link.to), AByMomentum(N.node.link.from))
                    #N.sortAllMomentum
                      console.log linkByMomentum
                      D =
                        N: N
                        link: linkByMomentum
                        users: N.allLinks[linkByMomentum]


                      D.firstUsersLink = D.users[Object.keys(D.users)[0]]
                      D.state =
                        params:
                          from: linkstate.store(that.props.from)
                          to: linkstate.store(that.props.to)
                        connections:
                          from: D.firstUsersLink.from
                          to: D.firstUsersLink.to
                      D.m= D.firstUsersLink.meta
                      U = # {} # users votes loop object
                        D: D
                        usersConnections: N.inLinks[D.link]
                      #for type, tuple of D.state
                      #console.log D
                      for param, paramLink of D.state.params
                        for here, nodeLink of D.state.connections
                          # we want the one that is not params from
                          notSameLink = paramLink != nodeLink
                          notFrom = D.state.params.from != D.state.connections.from
                          notTo = D.state.params.from != D.state.connections.to
                          if notFrom
                            D.drawTheOther = D.firstUsersLink.from
                          if notTo
                            D.drawTheOther = D.firstUsersLink.to
                          console.log D.drawTheOther
                          if here is 'from' and param is 'to'
                            D.drawTheOther = drawTheOther param, paramLink, here, nodeLink, D.firstUsersLink
                            if D.drawTheOther?.ScreenshotUrl?
                              N.UrlBoxDraw[linkByMomentum] = {D,U}
                              draw++
                    for key, object of N.UrlBoxDraw
                      console.log key, object
                      k.build UrlBox,
                        D: object.D
                        N: N
                        U: object.U
                        from: that.props.from
                        to: that.props.to
                        props: that.props
                        thumbalizr: that.props.thumbalizr
                        word: that.props.word
                        user: that.props.user



drawTheOther = (param, paramLink, here, nodeLink, hereNode) ->
  # if the link.. is the place we are now...
  # that should NOT be the ScreenshotUrl
  # because it's assumed we're talking about the other
  # does it matter if we point to a place? not just from? we could
  #.. put it in the first position since it's of special interest
  # how do we find ' the other?'
  console.log here, paramLink == nodeLink
  if paramLink == nodeLink and param == 'from'
    n++
    if here is 'to'
      console.log paramLink, param, nodeLink, paramLink == nodeLink, here
      # we're point to the place we are, use the other link for ScreenshotUrl
      returner =
        ScreenshotUrl: linkstate.thumbalizrPic(hereNode.from)
        otherUrl: hereNode.from
        otherTitle: hereNode.meta.title
      console.log returner
    if here == 'from'
      # self ref
      returner = false
    # how do we detect same orientation as queryParams?
    console.log returner
    return returner
noNodeFirst = new Date().getTime()
noNodeYet = 0
gotNodeNow = 0

exports.AboutCard = createContainer ((props) ->

  newProps = {}
  nodeHandle = Meteor.subscribe "Node", props.from
  if nodeHandle.ready()
    N = Nodes.findOne(linkstate.store props.from)
    if N?
      newProps.node = N
      gotNodeNow = new Date().getTime()
      console.log 'node timing',  gotNodeNow - noNodeYet, gotNodeNow - noNodeFirst
      Meteor.call 'GroundedNodeInsert', N
  else
    if Meteor.isClient
      node = localStorage.getItem 'latestNode'
      if node?
        N = node
        noNodeYet = new Date().getTime()
  props = _.extend {}, props, newProps
  props
), AboutCard
