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
{Winged, VisualCue, wingMark} = require '../ui/ShadowMoon.coffee'

R = require 'ramda'
UrlBox = React.createClass
  propTypes:
    D: React.PropTypes.object
  render: ->
    that = this
    reactKup (k) ->
      {D,N,U} = that.props
      measurements =
        D: 300
        d: 5
        M: 100
      thumbalizr = that.props.thumbalizr
      k.build GridTile,
        key: D.link+'Node'
        title: linkstate.see D.drawTheOther.otherUrl#m.FromLink
        #subtitle: D.drawTheOther.otherTitle#that.props.word.to + D.m.ToLink
        onClick: (e) ->
          GoMark
            type:
              from: D.m.FromLink
              to: D.m.ToLink
            N: N.node
            user: that.props.user
        ->
          k.build Winged,
            ScreenshotUrl: D.drawTheOther.ScreenshotUrl
            user: that.props.user
            from: that.props.from
            measurements: measurements
          inlink = N.inLinks?[D.link]?
          outlink = N.outLinks?[D.link]?
          U.directionUserMeta = {}
          if outlink
            U.directionUserMeta.OUTLINKS = N.outLinks[D.link]
          if inlink
            U.directionUserMeta.INLINKS = N.inLinks[D.link]
          counted = 0
          loopi =
            lastWeight: false
            offsetSequence: 0
          for directedBunch of U.directionUserMeta
            for userVectorName of U.directionUserMeta[directedBunch]
              counted++
              meta = U.directionUserMeta[directedBunch][userVectorName].meta
              if loopi.lastWeight == meta.weight
                loopi.offsetSequence++
              else
                loopi.offsetSequence = 0
              k.build wingMark,
                loopi: loopi
                weight: meta.weight
                n: loopi.offsetSequence
                counted: counted
                size: style.scalars.screenshotWidth
                meta: meta
                directed: directedBunch
                measurements: measurements
###
              weights = [0..9]
              for directioned in ['INLINKS','OUTLINKS']
                for weighted in [0..9]
                  if loopi.lastWeight == meta.weight
                    loopi.offsetSequence++
                  else
                    loopi.offsetSequence = 0
                  k.build wingMark,
                    weight: weighted
                    n: 1
                    counted: 1
                    size: style.scalars.screenshotWidth
                    meta: meta
                    directed: directioned
                    measurements: measurements
###



exports.UrlBox = UrlBox
