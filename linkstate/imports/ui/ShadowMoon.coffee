
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
              tooltip: that.props.target.meta.body + ' - ' + linkstate.see that.props.target.from
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

#one one onlyOne
# a react that paints center and outside
# a react that defines what to put into places
# a rect that sets sizes and coordinates? no containers are supposed to be preprocessors

Winged = React.createClass
  render: ->
    that = this
    {user,from,N,ScreenshotUrl,measurements,firstWibeHere, dotlessLink} = that.props
    #{D,d,M} = measurements

    reactKup (k) ->
      k.div ->
        k.build Paper,
          circle: true
          style:
            maxWidth: measurements.D#'50%'
            maxHeight: measurements.D#'50%'
            marginRight: 0.5*measurements.D - measurements.M
            marginTop: measurements.M
            marginBottom: measurements.M
            float: 'right'
            display: 'inline'
          zDepth: 5
          ->
            k.build Avatar,
              style:
                width: measurements.D
                height: measurements.D
                marginRight: 0
                marginTop: 0
                marginBottom: 0
                float: 'right'
                display: 'inline'
              size: measurements.D/2
              src: firstWibeHere.meta.ScreenshotUrl#that.props.ScreenshotUrl
        inlink = N?.inLinks?[dotlessLink]?
        outlink = N?.outLinks?[dotlessLink]?
        U = {}
        U.directionUserMeta = {}
        if outlink
          U.directionUserMeta.OUTLINKS = N.outLinks[dotlessLink]
        if inlink
          U.directionUserMeta.INLINKS = N.inLinks[dotlessLink]
        counted = 0
        for directedBunch of U.directionUserMeta
          for userVectorName of U.directionUserMeta[directedBunch]
            counted++
            userVoteHere = U.directionUserMeta[directedBunch][userVectorName]
            continue unless userVoteHere?
            console.log counted
            , userVectorName
            , U.directionUserMeta[directedBunch]
            , ScreenshotUrl
            , U.directionUserMeta[directedBunch][userVectorName]
            , directedBunch
            k.build Orbitals,
              user: that.props.user
              ScreenshotUrl: ScreenshotUrl#that.props.ScreenshotUrl
              n: counted
              target: userVoteHere
              weight: userVoteHere.weight
              measurements: that.props.measurements
              directed: directedBunch is 'OUTLINKS'

Orbitals = React.createClass
  render: ->
    that = this
    body = that.props.target.meta.body
    L = body.length unless !body?
    floor = 5
    top = 50
    shadow = floor-Math.round(floor/Math.round(.5+L*(floor/top)))
    reactKup (k) ->
      console.log that.props, body, shadow
      k.build Paper,
        circle: true
        style:
          position: 'absolute'
          marginTop: upMargin that.props.measurements
          , that.props.weight
          marginLeft: rightMargin that.props.measurements
          , that.props.weight
          , that.props.n # negative N, should place it left or right of center
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
              tooltip: that.props.target.meta.body + ' - ' + linkstate.see that.props.target.from
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
###
        #console.log D, M, N, outlink, inlink, that.props?.user?.out?[linkstate.store that.props.from]?
        console.log 'firstWibeHere'
        , N.inLinks[firstWibeHere.from]
        , N.inLinks[firstWibeHere.to]
        , that.props
        , dotlessLink

        # aboutness shouldn't depend on user.. test functional..
        if that.props?.user?.links.out?[dotlessLink]?
          out = that.props.user.links.out[linkstate.store that.props.from]
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
              ScreenshotUrl: target.meta.ScreenshotUrl#that.props.ScreenshotUrl
              n: n
              target: target
              weight: target.meta.weight
              measurements: that.props.measurements
###
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
        if that.props?.user?.links?.out?[linkstate.store that.props.from]?
          out = that.props.user.links.out[linkstate.store that.props.from]
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
exports.VisualCue = VisualCue
exports.yourMark = yourMark
exports.shadowMoon = shadowMoon
exports.Winged = Winged
