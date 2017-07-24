
reactKup = require('react-kup')
React = require('react')
{style} = require('../ui/style.coffee')
{changeQueryParams, changeQueryParamsObject} = require('../api/changeQueryParams.coffee')
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
Toggle = require('material-ui/lib/toggle').default
{Mexplain} = require '../api/MexplainContainer.coffee'
{selectedContainer} = require '../api/Selected.coffee'
Print =  require('material-ui/lib/svg-icons/action/print').default
IconButton = require('material-ui/lib/icon-button').default
Paper = require('material-ui/lib/paper').default
Avatar = require('material-ui/lib/avatar').default
{shadowFloor, upMargin, rightMargin,Position} = require '../api/strings'

shadowMoon = React.createClass
  render: ->
    {D, d, M} = @props.measurements
    that = this
    reactKup (k) ->
      k.div
        style: that.props.styler
        ->
          k.build Paper,
            circle: true
            style:
              width: D
              height: D
              marginRight: -D/2
              marginTop: M
              marginBottom: M
              float: 'right'
              display: 'inline'
            zDepth: 5
            ->
              k.build Avatar,
                style:
                  width: D
                  height: D
                  marginRight: 0
                  marginTop: 0
                  marginBottom: 0
                  float: 'right'
                  display: 'inline'
                size: D/2
                src: that.props.ScreenshotUrl


VisualCue = React.createClass
  render: ->
    {D, d, M} = @props.measurements
    that = this
    reactKup (k) ->
      k.div
        style:
          position: 'relative'
        ->
          k.build Paper,
            circle: true
            style:
              width: D
              height: D
              left: D/2+M
              marginTop: 2*M
              marginBottom: M
              float: 'right'
              display: 'inline'
            zDepth: 5
            ->
              k.build Avatar,
                style:
                  width: D
                  height: D
                  marginRight: 0
                  marginTop: 0
                  marginBottom: 0
                  float: 'right'
                  display: 'inline'
                size: D/2
                src: that.props.ScreenshotUrl
          if that.props?.user?.out?[linkstate.store that.props.from]?
            out = that.props.user.out[linkstate.store that.props.from]
            n = 0
            outArrayByWeight = linkstate.sortByWeight(out, that.props.howMany)
            for key, mark of outArrayByWeight
              target = out[mark]
              arrayValue = outArrayByWeight[key]
              dictWeight = out[arrayValue].meta.weight
              lastKey = outArrayByWeight[key-1]
              if lastKey?
                if out[lastKey].meta.weight is out[mark].meta.weight
                  n++
                else
                  n = 0
              m = target.meta
              try
                thisWeight = out[mark].meta.weight
                lastWeight = (out[mark].meta.weight -1)
              catch error
              k.build yourMark,
                user: that.props.user
                ScreenshotUrl: that.props.ScreenshotUrl
                n: n
                target: target
                weight: target.meta.weight
                measurements: that.props.measurements


yourMark = React.createClass
  render: ->
    that = this
    body = that.props.target.meta.body
    L = body.length
    floor = 5
    top = 50
    shadow = floor-Math.round(floor/Math.round(.5+L*(floor/top)))
    {measurements,weight,n} = that.props
    {D,d,M} = measurements
    r = D/d
    reactKup (k) ->
      k.build Paper,
        circle: true
        style:
          position: 'absolute'
          top: M+Position
            measurements: measurements
            weight: weight
            n: n
            directed: 'INLINKS'
            axis: 'y'
          left: D/2+Position
            measurements: measurements
            weight: weight
            n: n
            directed: 'INLINKS'
            axis: 'x'
          width: r
          height: r
        zDepth: shadowFloor that.props.target.meta.body, 5 , 50
        overflow: 'hidden'
        ->
          k.div ->
            k.build IconButton,
              style:
                padding: 0
                width: r
                height: r
              tooltip: that.props.target.meta.body + ' - ' + linkstate.see(that.props.target.meta.FromLink) + ' to ' + linkstate.see(that.props.target.meta.ToLink)
              tooltipPosition: 'top-right'
              className: 'YourMarks'
              onClick: (e) ->
                changeQueryParamsObject
                  from: that.props.target.from
                  to: that.props.target.to
              ->
                k.build Avatar,
                  style:
                    width: r
                    height: r
                    float: 'left'
                  size: r
                  src: that.props.target.meta.ScreenshotUrl

Winged = React.createClass
  render: ->
    {D, d, M} = @props.measurements
    that = this
    reactKup (k) ->
      k.div ->
        k.build Paper,
          circle: true
          style:
            width: D
            height: D
            #marginRight: style.scalars.boxWidth/2-.75*D#'25%' #'auto' #Right: D/2
            left: M#D/2
            #marginRight: '25%'
            top: M
            marginBottom: M
            #float: 'left'
            #display: 'block'
            position: 'absolute'
          zDepth: 5
          ->
            k.build Avatar,
              style:
                width: D
                height: D
                marginRight: 0
                marginTop: 0
                marginBottom: 0
                float: 'right'
                display: 'inline'
              size: D/2
              src: that.props.ScreenshotUrl
        # draw the bullets.. as wings.. ed faces

wingMark = React.createClass
  render: ->
    that = this
    body = that.props.meta.body
    L = body.length
    floor = 5
    top = 50
    shadow = floor-Math.round(floor/Math.round(.5+L*(floor/top)))
    reactKup (k) ->
      {measurements,n,weight,meta,FromLink,ToLink,loopi,directed,from,to} = that.props
      {D,d,M} = measurements
      k.build Paper,
        circle: true
        style:
          meta: meta
          position: 'absolute'
          top: Position
            measurements: measurements
            weight: weight
            n: n
            directed: directed
            axis: 'y'
          left: Position
            measurements: measurements
            weight: weight
            n: n
            directed: directed
            axis: 'x'
          width: D/d
          height: D/d
        zDepth: shadowFloor that.props.meta.body, 5 , 50
        overflow: 'hidden'
        ->
          k.div ->
            k.build IconButton,
              style:
                padding: 0
                width: D/d
                height: D/d
              tooltip: that.props.meta.body
              tooltipPosition: 'top-right'
              className: 'YourMarks'
              onClick: (e) ->
                changeQueryParamsObject
                  from: that.props.FromLink
                  to: that.props.meta.FromLink
              ->
                k.build Avatar,
                  style:
                    width: D/d
                    height: D/d
                    float: 'left'
                  size: D/d
                  src: that.props.meta.face

exports.VisualCue = VisualCue
exports.yourMark = yourMark
exports.shadowMoon = shadowMoon
exports.Winged = Winged
exports.wingMark = wingMark
