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
{LinkVote} = require '../../imports/ui/LinkVote.coffee'
{GoMark} = require '../../imports/api/nav/GoMark.coffee'
{Winged} = require '../ui/ShadowMoon'
R = require 'ramda'
UrlBox = React.createClass
  propTypes:
    D: React.PropTypes.object
  render: ->
    that = this
    reactKup (k) ->
      {D,N,U,thumbalizr,user,word,from,to} = that.props
      k.build GridTile,
        key: D.link+'Node'
        title: D.m.title#m.FromLink
        subtitle: D.m.FromLink#[that.props.type]#that.props.word.to + D.m.ToLink
        onClick: (e) ->
          GoMark
            type:
              from: D.m.FromLink
              to: D.m.ToLink
            N: N.node
            user: that.props.user
        ->
          k.build Winged,
            ScreenshotUrl: that.props.ScreenshotUrl
            user: that.props.user
            from: D.m.FromLink#that.props.from
            measurements:
              D: 300
              d: 60
              M: 50
            N: N
            U: U
            D: D

oldBullet = React.createClass
  render: ->
    reactKup (k) ->
      k.div ->
        k.div
          style: style.fromBullet
          ->
            k.img
              style: _.extend {}, style.webShot,
                opacity: .7
                zIndex: 2
              src: linkstate.thumbalizrPic D.m.FromLink
        k.img
          style: _.extend {}, style.webShot,
            position: 'absolute'
            left: '30%'
            zIndex: -1
          src:linkstate.thumbalizrPic D.m.ToLink
      inlink = N.inLinks?[D.link]?
      outlink = N.outLinks?[D.link]?
      U = {}
      U.directionUserMeta = {}
      if outlink
        U.directionUserMeta.OUTLINKS = N.outLinks[D.link]
      if inlink
        U.directionUserMeta.INLINKS = N.inLinks[D.link]
      counted = 0
      for directedBunch of U.directionUserMeta
        for userVectorName of U.directionUserMeta[directedBunch]
          counted++
          k.build LinkVote,
            counted: counted
            size: style.scalars.screenshotWidth
            meta: U.directionUserMeta[directedBunch][userVectorName].meta
            directed: directedBunch
exports.UrlBox = UrlBox
