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
{shadowFloor, upMargin, rightMargin, Position} = require '../api/strings'
# {VisualCue, yourMark} = require '../ui/ShadowMoon.coffee'
# TODO functional testable convenience functions, like strings, for math and attribute getting
Lo = require 'lodash'


exports.MyCard = React.createClass
  getDefaultProps: ->
    expanded: true
  render: ->
    that = this
    if @props.expanded is 'undefined'
      that.props.expanded = true
    reactKup (k) ->
      {D,d,M} = that.props.styles.measurements
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
                styles: that.props.styles
                ScreenshotUrl: that.props.ScreenshotUrl
                user: that.props.user
                from: that.props.from
                measurements: measurements



VisualCue = React.createClass
  render: ->
    {D, d, M} = @props.styles.measurements
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
              top: M
              left: M#D/2+M
              #marginTop: 2*M
              #marginBottom: M
              #float: 'right'
              position: 'absolute'
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
          linktohere = that.props?.user?.links?.in?[linkstate.store that.props.from]?
          console.log linktohere
          if linktohere
            inLinks = that.props.user.links.in[linkstate.store that.props.from]
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
              console.log key, mark
              try
                thisWeight = inLinks[mark].meta.weight
                #lastWeight = inLinks[mark].meta.weight
              catch error
                console.log error
              markprops =
                user: that.props.user
                ScreenshotUrl: that.props.ScreenshotUrl
                n: n
                target: target
                weight: target.meta.weight
                measurements: that.props.styles.measurements
                styles: that.props.styles
              console.log markprops
              k.build yourMark, markprops


yourMark = React.createClass
  render: ->
    that = this
    console.log @props
    floor = 5
    top = 50
    shadow = floor-Math.round(floor/Math.round(.5+L*(floor/top)))
    {styles,weight,n,target,n,ScreenshotUrl} = that.props
    {measurements} = styles
    {D,d,M} = styles.measurements
    r = D/d
    if target?.meta?.body?
      body = that.props.target.meta.body
      L = body.length
    else
      L = 0
      body = ''

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
          left: M+Position
            measurements: measurements
            weight: weight
            n: n
            directed: 'INLINKS'
            axis: 'x'
          width: r
          height: r
        zDepth: shadowFloor body, 5 , 50
        overflow: 'hidden'
        ->
          text = Lo.get that.props, 'target.meta.body'
          if !text
            text = ''
          k.div ->
            k.build IconButton,
              style:
                padding: 0
                width: r
                height: r
              tooltip: text + ' - ' + linkstate.see(that.props.target.meta.FromLink) + ' to ' + linkstate.see(that.props.target.meta.ToLink)
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
#exports.yourMark = yourMark
#exports.shadowMoon = shadowMoon
