# MyCard.coffee shows my incomming connections TO the place you are at
# because if you go TO bookmarks, you will see your bookmarks
# this is because bookmarks are links to bookmarks
# Bookmarks are here steps, auto generated when you newtab from a page.
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
{shadowFloor, upMargin, rightMargin} = require '../api/strings'
# TODO functional testable convenience functions, like strings, for math and attribute getting
yourMark = React.createClass
  render: ->
    that = this
    body = that.props.target.meta.body
    L = body.length
    floor = 5
    top = 50
    shadow = floor-Math.round(floor/Math.round(.5+L*(floor/top)))
    reactKup (k) ->
      k.build Paper,
        circle: true
        style:
          position: 'absolute'
          marginTop: upMargin that.props.measurements
          , that.props.weight
          marginLeft: rightMargin that.props.measurements
          , that.props.weight
          , that.props.n
          width: 80
          height: 80
        zDepth: shadowFloor that.props.target.meta.body, 5 , 50
        overflow: 'hidden'
        ->
          k.div ->
            k.build IconButton,
              style:
                padding: 0
                width: 80
                height: 80
              tooltip: that.props.target.meta.body
              tooltipPosition: 'top-right'
              className: 'YourMarks'
              onClick: (e) ->
                changeQueryParamsObject
                  from: that.props.target.from
                  to: that.props.target.to
              ->
                k.build Avatar,
                  style:
                    width: 80
                    height: 80
                    float: 'left'
                  size: 80
                  src: that.props.target.meta.ScreenshotUrl
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
      k.div ->
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
exports.MyCard = React.createClass
  getDefaultProps: ->
    expanded: true
  render: ->
    that = this
    if @props.expanded is 'undefined'
      that.props.expanded = true
    reactKup (k) ->
      D = 400
      d = 80
      M = 150
      measurements = {D, d, M}
      k.build Card,
        expanded: that.props.expanded
        style: _.extend {}, style.card, style.yCard
        ->
          k.build CardText,
            style:
              height: 'auto'
              minHeight: 500
              overflow: 'hidden'
            expandable: false
            ->
              k.build selectedContainer,
                from: that.props.from
                to: that.props.to
                lastTitle: that.props.lastTitle
                user: that.props.user
                type: 'from'
                word: that.props.word
                lastTitle: that.props.lastTitle
              k.build VisualCue,
                ScreenshotUrl: that.props.ScreenshotUrl
                user: that.props.user
                from: that.props.from
                measurements: measurements
exports.yourMark = yourMark
exports.shadowMoon = shadowMoon
