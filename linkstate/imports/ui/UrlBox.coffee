#reactKup = require('react-kup')
React = require('react')
{style} = require('../ui/style.coffee')
# {changeQueryParams} = require('../api/changeQueryParams.coffee')
# {FromToSense} = require('../ui/FromToSense.coffee')
# Card = require('material-ui/lib/card/card').default
# CardActions = require('material-ui/lib/card/card-actions' ).default
# CardHeader = require('material-ui/lib/card/card-header').default
# CardMedia = require('material-ui/lib/card/card-media').default
# CardTitle = require('material-ui/lib/card/card-title').default
# FlatButton = require('material-ui/lib/flat-button' ).default
# CardText =  require('material-ui/lib/card/card-text').default
{GridList, GridTile} = require 'material-ui/lib/grid-list' #(GridTile)not in material-ui,@material-ui/core/GridListTile not working
# {Subheader} = require 'material-ui/lib/Subheader'
# {StarBorder} = require 'material-ui/lib/svg-icons/toggle/star-border'
# {bulletUnitContainer} = require '../../imports/api/bulletUnit.coffee'
# # {LinkVote} = require '../../imports/ui/LinkVote.coffee'
{GoMark} = require '../../imports/api/nav/GoMark.coffee'
{Winged, VisualCue, wingMark} = require '../ui/ShadowMoon.coffee'
# {createContainer} = require 'meteor/react-meteor-data'
Lo = require 'lodash'
R = require 'ramda'
# break this out into a dumb component and pre massaging
{linkstate} = require '../api/strings'
UrlBox = React.createClass
  propTypes:
    D: React.PropTypes.object
  render: ->
    that = this
    # #reactKup (k) ->
    {D,N,U} = that.props
    U.directionUserMeta = {}
    inlink = N.inLinks?[D.link]?
    if inlink
      U.directionUserMeta.INLINKS = N.inLinks[D.link]
    outlink = N.outLinks?[D.link]?
    if outlink
      U.directionUserMeta.OUTLINKS = N.outLinks[D.link]
    counted = 0
    loopi =
      "lastWeight": false
      "offsetSequence": 0
    measurements =
      D: 300
      d: 4
      M: 100
    thumbalizr = that.props.thumbalizr
    React.createElement GridTile, {
      "key": D.link+'Node'
      "title": linkstate.see D.drawTheOther.otherUrl#m.FromLink
      #subtitle: D.drawTheOther.otherTitle#that.props.word.to + D.m.ToLink
      onClick: ->
        GoMark
          type:
            from: D.m.FromLink
            to: D.m.ToLink
          N: N.node
          user: that.props.user
      },
        React.createElement Winged, {
          "ScreenshotUrl": D.drawTheOther
          "user": that.props.user
          "from": that.props.from
          "measurements": measurements
        }
        if !that.props.ScreenshotUrl #D.drawTheOther, N.allLinks[D.drawTheOther],
          console.log 'no screenshoturl here', D.m.FromLink, D.m.ToLink #,that.props,
        for directedBunch of U.directionUserMeta
          for userVectorName of U.directionUserMeta[directedBunch]
            counted++
            meta = U.directionUserMeta[directedBunch][userVectorName].meta
            # sometimes meta does not have a body
            unless meta.body?
              meta.body = ''
            if loopi.lastWeight == meta.weight
              loopi.offsetSequence++
            else
              loopi.offsetSequence = 0
            React.createElement wingMark, {
              "loopi": loopi
              "weight": meta.weight
              "n": loopi.offsetSequence
              "counted": counted
              "size": style.scalars.screenshotWidth
              "meta": meta
              "directed": directedBunch
              "measurements": measurements
            }

exports.UrlBox = UrlBox
