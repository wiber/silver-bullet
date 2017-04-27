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
          k.build CardText,
            expandable: true
            ->
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

                    for timeLink in N.sortAllMomentum
                      D = {}
                      D.N = N
                      D.link = timeLink
                      D.users = N.allLinks[timeLink]
                      D.firstUsersLink = D.users[Object.keys(D.users)[0]]
                      D.m = D.firstUsersLink.meta
                      U = {} # users votes loop object
                      U.D = D
                      U.usersConnections = N.inLinks[D.link]
                      k.build UrlBox,
                        D: D
                        N: N
                        U: U
                        from: that.props.from
                        to: that.props.to
                        props: that.props
                        thumbalizr: that.props.thumbalizr
                        word: that.props.word
                        user: that.props.user


exports.AboutCard = createContainer ((props) ->

  newProps = {}
  nodeHandle = Meteor.subscribe "Node", props.from
  if nodeHandle.ready()
    N = Nodes.findOne(linkstate.store props.from)
    if N?
      newProps.node = N
  props = _.extend {}, props, newProps
  props
), AboutCard
