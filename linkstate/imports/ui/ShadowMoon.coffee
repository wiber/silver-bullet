
#reactKup = require('react-kup')
React = require('react')
{style} = require('../ui/style.coffee')
{changeQueryParams, changeQueryParamsObject} = require('../api/changeQueryParams.coffee')
# Card = require('material-ui/lib/card/card').default
# CardActions = require('material-ui/lib/card/card-actions' ).default
# CardHeader = require('material-ui/lib/card/card-header').default
# CardMedia = require('material-ui/lib/card/card-media').default
# CardTitle = require('material-ui/lib/card/card-title').default
# FlatButton = require('material-ui/lib/flat-button' ).default
# CardText =  require('material-ui/lib/card/card-text').default
# {GridList, GridTile} = require 'material-ui/lib/grid-list'
# {Subheader} = require 'material-ui/lib/Subheader'
# {StarBorder} = require 'material-ui/lib/svg-icons/toggle/star-border'
# Toggle = require('material-ui/lib/toggle').default
# {Mexplain} = require '../api/MexplainContainer.coffee'
# {selectedContainer} = require '../api/Selected.coffee'
# Print =  require('material-ui/lib/svg-icons/action/print').default
IconButton = require('material-ui/lib/icon-button').default #not working @material-ui/core/IconButton
Paper = require('material-ui/lib/paper').default #@material-ui/core/Paper not working
Avatar = require('material-ui/lib/avatar').default # @material-ui/core/Avatar not working
{shadowFloor, upMargin, rightMargin,Position} = require '../api/strings'
Lo = require 'lodash'
{see, store, linkstate} = require '../api/strings'

shadowMoon = React.createClass
  render: ->
    {D, d, M} = @props.measurements
    that = this
    div
      style: that.props.styler
      ->
      React.createElement Paper, {
        "circle": true
        "zDepth": 5
        "style": {
          "width": D
          "height": D
          "marginRight": -D/2
          "marginTop": M
          "marginBottom": M
          "float": 'right'
          "display": 'inline'
          }
        },
          React.createElement Avatar, {
            "style": {
              "width": D
              "height": D
              "marginRight": 0
              "marginTop": 0
              "marginBottom": 0
              "float": 'right'
              "display": 'inline'
              }
            "size": D/2
            "src": that.props.ScreenshotUrl
          }


VisualCue = React.createClass
  render: ->
    {D, d, M} = @props.measurements
    that = this
    div
      style:
        position: 'relative'
      ->
        React.createElement Paper,{
          "circle": true
          "zDepth": 5
          "style":{
            "width": D
            "height": D
            "left": D/2+M
            "marginTop": 2*M
            "marginBottom": M
            "float": 'right'
            "display": 'inline'
          }
        },
          React.createElement Avatar,{
            "style":{
              "width": D
              "height": D
              "marginRight": 0
              "marginTop": 0
              "marginBottom": 0
              "float": 'right'
              "display": 'inline'
            "size": D/2
            "src": that.props.ScreenshotUrl
            }
          }
        # TODO mismatched queryparam with lastTitle, why?
        # selectize needs to read the user object only..
        # remove direct reliance on qp and harden localstore management of user model
        #console.log that.props?.user?.link?.to
        #console.log FlowRouter.getQueryParam('from'), FlowRouter.getQueryParam('lastTitle')
        #console.log that.props?.user?.link?.to?[linkstate.store that.props.from]?
        if that.props?.user?.link?.to?[linkstate.store that.props.from]?
          inLinks = that.props.user.link.to[linkstate.store that.props.from]
          n = 0
          inLinksArrayByWeight = linkstate.sortByWeight(inLinks, that.props.howMany)
          for key, mark of inLinksArrayByWeight
            target = inLinks[mark]
            arrayValue = inLinksArrayByWeight[key]
            dictWeight = inLinks[arrayValue].meta.weight
            lastKey = inLinksArrayByWeight[key-1]
            if lastKey?
              if inLinks[lastKey].meta.weight is inLinks[mark].meta.weight
                n++
              else
                n = 0
            m = target.meta
            try
              thisWeight = inLinks[mark].meta.weight
              lastWeight = (inLinks[mark].meta.weight -1)
            catch error
            React.createElement yourMark,{
              "user": that.props.user
              "ScreenshotUrl": that.props.ScreenshotUrl
              "n": n
              "target": target
              "weight": target.meta.weight
              "measurements": that.props.measurements
            }


yourMark = React.createClass
  render: ->
    that = this
    body = that.props.target.meta.body
    if body?
      L = body.length
    else
      L = 0
      body = ''
    floor = 5
    top = 50
    shadow = floor-Math.round(floor/Math.round(.5+L*(floor/top)))
    {measurements,weight,n} = that.props
    {D,d,M} = measurements
    r = D/d
    React.createElement Paper,{
      "circle": true
      "style": {
        "position": 'absolute'
        "top": M+Position
          "measurements": measurements
          "weight": weight
          "n": n
          "directed": 'INLINKS'
          "axis": 'y'
        "left": D/2+Position
          "measurements": measurements
          "weight": weight
          "n": n
          "directed": 'INLINKS'
          "axis": 'x'
        "width": r
        "height": r
      "zDepth": shadowFloor body, 5 , 50
      "overflow": 'hidden'
      }
    }
    ->
      text = Lo.get that.props, 'target.meta.body'
      if !text
        text = ''
      div ->
        React.createElement IconButton,{
          "style":{
            "padding": 0
            "width": r
            "height": r
          }
          "tooltip": text + ' - ' + linkstate.see(that.props.target.meta.FromLink) + ' to ' + linkstate.see(that.props.target.meta.ToLink)
          "tooltipPosition": 'top-right'
          "className": 'YourMarks'
        }
        onClick: (e) ->
          changeQueryParamsObject
            from: that.props.target.from
            to: that.props.target.to
        ->
          React.createElement Avatar,{
            "style":{
              "width": r
              "height": r
              "float": 'left'
            }
            "size": r
            "src": Lo.get that.props, 'target.meta.ScreenshotUrl'
          }

Winged = React.createClass
  render: ->
    {D, d, M} = @props.measurements
    that = this
    div
      className: 'showmoon'
      React.createElement Paper, {
        "circle": true
        "style": {
          "width": D
          "height": D
          #marginRight: style.scalars.boxWidth/2-.75*D#'25%' #'auto' #Right: D/2
          "left": M#D/2
          #marginRight: '25%'
          "top": M
          "marginBottom": M
          #float: 'left'
          #display: 'block'
          "position": 'absolute'
        }
        "zDepth": 5
      },
        React.createElement Avatar, {
          "style": {
            "width": D
            "height": D
            "marginRight": 0
            "marginTop": 0
            "marginBottom": 0
            "float": 'right'
            "display": 'inline'
          }
          "size": D/2
          "src": that.props.ScreenshotUrl
        }

wingMark = React.createClass
  render: ->
    that = this
    {loopi, meta, weight, counted, size, meta, directed, measurements, from, to, thumbalizr, word, user, n} = that.props
    body = meta.body
    try
      bodyLen =  body.length
    catch error
      console.error 'this body does not have length', meta

    floor = 5
    top = 50
    shadow = floor-Math.round(floor/Math.round(.5+bodyLen*(floor/top)))
    #{measurements,n,weight,meta,FromLink,ToLink,loopi,directed,from,to} = that.props
    {D,d,M} = measurements
    React.createElement Paper,{
      "circle": true
      "style":{
        "meta": meta
        "position": 'absolute'
        "top": Position
          "measurements": measurements
          "weight": weight
          "n": n
          "directed": directed
          "axis": 'y'
        "left": Position
          "measurements": measurements
          "weight": weight
          "n": n
          "directed": directed
          "axis": 'x'
        "width": D/d
        "height": D/d
      }
      "zDepth": shadowFloor that.props.meta.body, 5 , 50
      "overflow": 'hidden'
    },
      div
        div
          style: _.extend {}
          React.createElement IconButton,{
            "style":
              "padding": 0
              "width": D/d
              "height": D/d
            "tooltip": that.props.meta.body
            "tooltipPosition": 'top-right'
            "className": 'YourMarks'
          },
            React.createElement Avatar,{
              "style":{
                "width": D/d
                "height": D/d
                "float": 'left'
              }
              "size": D/d
              "src": that.props.meta.face.replace('http:','https:') if that?.props?.meta?.face?
            }

exports.VisualCue = VisualCue
exports.yourMark = yourMark
exports.shadowMoon = shadowMoon
exports.Winged = Winged
exports.wingMark = wingMark
