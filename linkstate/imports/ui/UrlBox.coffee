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
R = require 'ramda'
UrlBox = React.createClass
  propTypes:
    D: React.PropTypes.object
  render: ->
    that = this
    reactKup (k) ->
      D = that.props.D
      N = that.props.N
      U = that.props.U
      thumbalizr = that.props.thumbalizr
      k.build GridTile,
        key: D.link+'Node'
        title: D.m.FromLink
        subtitle: that.props.word.to + D.m.ToLink
        ->
          k.div ->
            k.div
              style: style.fromBullet
              ->
                k.img
                  style: _.extend {}, style.webShot,
                    opacity: .7
                    zIndex: 2
                  src: linkstate.thumbalizrPic D.m.FromLink
                  from: D.m.FromLink
                  onClick: (e) ->
                   changeQueryParams 'from', e.target.getAttribute('from')
            k.img
              style: _.extend {}, style.webShot,
                position: 'absolute'
                left: '30%'
                zIndex: -1
              src:linkstate.thumbalizrPic D.m.ToLink
              to: D.m.ToLink
              onClick: (e) ->
               changeQueryParams 'to', e.target.getAttribute('to')
          # are there user votes here?
          inlink = N.inLinks?[D.link]?
          outlink = N.outLinks?[D.link]?
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
