# renders the aboutness node from here
#reactKup = require('react-kup')
React = require('react')
{style} = require('../ui/style.coffee')
# {changeQueryParams} = require('../api/changeQueryParams.coffee')
# {FromToSense} = require('../ui/FromToSense.coffee')
Card = require('@material-ui/core/Card').default
# CardActions = require('material-ui/lib/card/card-actions' ).default
CardHeader = require('@material-ui/core/CardHeader').default
# CardMedia = require('material-ui/lib/card/card-media').default
# CardTitle = require('material-ui/lib/card/card-title').default
# FlatButton = require('material-ui/lib/flat-button' ).default
CardText =  require('@material-ui/core/CardContent').default #change CardText to CardContent
{GridList, GridTile} = require 'material-ui/lib/grid-list' #@material-ui/core/GridList not working
# {Subheader} = require 'material-ui/lib/Subheader'
# {StarBorder} = require 'material-ui/lib/svg-icons/toggle/star-border'
# {bulletUnitContainer} = require '../../imports/api/bulletUnit.coffee'
{UrlBox} = require '../../imports/ui/UrlBox.coffee'
# {hereAndThere} = require('../api/ModelOperations.coffee')
R = require 'ramda'
Lo = require 'lodash'
{see, store, linkstate} = require '../api/strings'
{createContainer} = require 'meteor/react-meteor-data'
{see, store, AByMomentum, listByMomentum, urlbox} = require '../api/strings.coffee'
n = 0
AboutCard = React.createClass
  render: ->
    that = this
    div
      className: 'nothing'
      React.createElement Card, {"style": _.extend {}, style.card, style.mAcard},#"expanded": that.props.expanded,
        React.createElement CardHeader, {
          "title": that.props.word.AboutCardTitle
          # "showExpandableButton": true
          "subtitle": that.props.word.AboutCardSubTitle
          }
        React.createElement CardText, {
          "style": {"height": 'auto'}
          }
        div
          style: _.extend {}, style.base,
            display: 'inline'
            # flexWrap: 'wrap'
          if that.props.node?.links?.in? or that.props.node?.links?.out?
            N = {}
            N.node = that.props.node
            N.inLinks = that.props.node.links.out
            N.outLinks = that.props.node.links.in
            N.link = N.node.link
            N.allLinks = _.extend {}, N.inLinks, N.outLinks
            N.linksByTime = linkstate.sortByKeysTime(N.allLinks
            , that.props.howMany)
            N.linkSort = {}
            #console.log N
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
            N.sortAllMomentum = listByMomentum(N.rankedinLinks, N.rankedOutlinks)
            draw = 0
            N.UrlBoxDraw = {}
            for linkByMomentum in N.sortAllMomentum #listByMomentum(AByMomentum(N.node.links.to), AByMomentum(N.node.links.from))
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
              # find the link that is not
              # the place where we are.. because one of them is
              # is this outdate?
              # we want to draw all links in and out or here .
              # because we are at a place.. it's assumed to be the origin
              # so we simply draw the one that isn't the from
              #
              for param, paramLink of D.state.params # from/to url on the node link
                for here, nodeLink of D.state.connections
                  # we want the one that is not params from
                  binaryState =
                    notSameLink: paramLink != nodeLink

                    notFrom: D.state.params.from != D.state.connections.from
                    notTo: D.state.params.from != D.state.connections.to
                  notSameLink = paramLink != nodeLink

                  notFrom = D.state.params.from != D.state.connections.from
                  notTo = D.state.params.from != D.state.connections.to
                  # find the screenshoturl on the first users link there..
                  if notFrom
                    D.drawTheOther = D.firstUsersLink.meta.ScreenshotUrl#from
                    #Lo.get D, '.state.connections.from.meta.ScreenshotUrl'
                  else
                    #D.drawTheOther = D.firstUsersLink.to
                    D.drawTheOther = D.firstUsersLink.meta.ScreenshotUrlTo
                  N.UrlBoxDraw[D.drawTheOther] =
                    #obj: D.allLinks[D.drawTheOther]
                    U: U
                    D: D
                  draw++
                  if here is 'from' and param is 'to'
                    D.drawTheOther = drawTheOther param, paramLink, here, nodeLink, D.firstUsersLink
                    if D.drawTheOther?.ScreenshotUrl?
                      N.UrlBoxDraw[linkByMomentum] = {D,U}
                      draw++
            React.createElement GridList, {"className": "looplist", "cellHeight": 500, "cols": 1},
              for key, object of N.UrlBoxDraw
                React.createElement UrlBox, {
                  "D": object.D
                  "N": N
                  "U": object.U
                  "from": that.props.from
                  "to": that.props.to
                  "props": that.props
                  "thumbalizr": that.props.thumbalizr
                  "word": that.props.word
                  "user": that.props.user
                  "ScreenshotUrl": Lo.get(N.allLinks, D.drawTheOther+'.meta.ScreenshotUrl')
                  }



drawTheOther = (param, paramLink, here, nodeLink, hereNode) ->
  # if the link.. is the place we are now...
  # that should NOT be the ScreenshotUrl
  # because it's assumed we're talking about the other
  # does it matter if we point to a place? not just from? we could
  #.. put it in the first position since it's of special interest
  # how do we find ' the other?'
  if paramLink == nodeLink and param == 'from'
    n++
    if here is 'to'
      # we're point to the place we are, use the other link for ScreenshotUrl

      returner =
        ScreenshotUrl: urlbox.buildUrl #linkstate.thumbalizrPic(hereNode.from)
          url: hereNode.from #that.props.from
          thumb_width: 320
          format: 'png'
          quality: 80
        otherUrl: hereNode.from
        otherTitle: hereNode.meta.title
    if here == 'from'
      # self ref
      returner = false
    # how do we detect same orientation as queryParams?
    return returner
noNodeFirst = new Date().getTime()
noNodeYet = 0
gotNodeNow = 0

exports.AboutCard = createContainer ((props) ->
  newProps = {}
  nodeHandle = Meteor.subscribe "Node", props.from
  if nodeHandle.ready()
    nodeId = linkstate.store props.from
    # @nicolson # fixme this should be done in layout api container
    # so that we can resolve app state before we load the app
    # where should we point to? what should be in the select fields?
    # functions in ModelOperations
    # save the whole model to localStorage untill db is hot
    # one interface for the model.
    # set the state to the url param from the ModelOperations
    # indicate to user with grayish background / opacity that data is loading

    N = Nodes.findOne(nodeId)
    if N?
      newProps.node = N
      gotNodeNow = new Date().getTime()
      #console.log 'node timing',  gotNodeNow - noNodeYet, gotNodeNow - noNodeFirst
      Meteor.call 'GroundedNodeInsert', N
  else
    if Meteor.isClient
      node = localStorage.getItem nodeId
      if node?
        N = JSON.parse node
        noNodeYet = new Date().getTime()
  ###
  nodeHandle = Meteor.subscribe "Node", linkstate.store(props.from)
  unless nodeHandle.ready()
    Meteor.call 'getStaticNode', props.from, (error, result) ->
  #  staticNode = result
  if !staticNode
    staticNode = {}
  newProps.staticNode = staticNode
  ###
  #if nodeHandle.ready()
  #  node = Nodes.findOne(linkstate.store(decodeURIComponent(queryParams.from)))
  returnProps = _.extend {}, props, newProps
  #console.log {staticNode, node, props,newProps, returnProps, nodeHandle, N}
  returnProps
), AboutCard
