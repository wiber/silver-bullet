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
{see, store, linkstate} = require '../api/strings'
`import {
  FacebookShareButton,
  GooglePlusShareButton,
  LinkedinShareButton,
  TwitterShareButton,
  TelegramShareButton,
  WhatsappShareButton,
  PinterestShareButton,
  VKShareButton,
  OKShareButton,
  RedditShareButton,
  TumblrShareButton,
  LivejournalShareButton,
  MailruShareButton,
  ViberShareButton,
  WorkplaceShareButton,
  EmailShareButton,
} from 'react-share';`
`import {
  FacebookIcon,
  TwitterIcon,
  TelegramIcon,
  WhatsappIcon,
  GooglePlusIcon,
  LinkedinIcon,
  PinterestIcon,
  VKIcon,
  OKIcon,
  RedditIcon,
  TumblrIcon,
  LivejournalIcon,
  MailruIcon,
  ViberIcon,
  WorkplaceIcon,
  EmailIcon,
} from 'react-share';`

exports.MyCard = React.createClass
  getDefaultProps: ->
    expanded: true
  render: ->
    console.log window.location.href,'console.log window.location.href,'
    that = this
    if @props.expanded is 'undefined'
      that.props.expanded = true
    # reactKup (k) ->
    {D,d,M} = that.props.styles.measurements
    measurements = {D, d, M}
    React.createElement Card,{
      # expanded: that.props.expanded
      "style": _.extend {}, style.card, style.yCard
    },
      React.createElement CardText,{
        "style":{
          "height": 'auto'
          "minHeight": 600
          #overflow: 'hidden'
        }
        expandable: false
      },
        React.createElement selectedContainer,{
          "from": that.props.from
          "to": that.props.to
          "lastTitle": that.props.lastTitle
          "user": that.props.user
          "type": 'from'
          "word": that.props.word
          "lastTitle": that.props.lastTitle
        }
        React.createElement CardActions,
          ->
            React.createElement FacebookShareButton,
              url: 'https://linkstate.youiest.com/about/'+window.location.search
              quote: "Is this for real? Let's find sources for and against this on linkstate!"
              hashtag: 'linkstate'
              style:
                display: "inline-block"
              ->
                React.createElement FacebookIcon,
                  size: 33
            React.createElement TwitterShareButton,
              url: 'https://linkstate.youiest.com/about/'+window.location.search
              title: "Is this for real? Let's find sources for and against this on linkstate!"
              via: "youiest"
              hashtags: ['linkstate','expose']
              style:
                display: 'inline-block'
              ->
                React.createElement TwitterIcon,
                  size: 33
            React.createElement WhatsappShareButton,
              url: 'https://linkstate.youiest.com/about/'+window.location.search
              title: "Is this for real? Let's find sources for and against this on linkstate!"
              style:
                display: 'inline-block'
              ->
                React.createElement WhatsappIcon,
                  size: 33
            React.createElement EmailShareButton,
              url: 'https://linkstate.youiest.com/about/'+window.location.search
              body: "Is this for real? Let's find sources for and against this on linkstate!"
              sibject: "I found something. Seen anything like this?"
              style:
                display: 'inline-block'
              ->
                React.createElement EmailIcon,
                  size: 33
        React.createElement VisualCue,{
          "styles": that.props.styles
          "ScreenshotUrl": that.props.ScreenshotUrl
          "user": that.props.user
          "from": that.props.from
          "measurements": measurements
        }



VisualCue = React.createClass
  render: ->
    {D, d, M} = @props.styles.measurements
    that = this
    # reactKup (k) ->
    div
      style:
        position: 'relative'
      ->
        React.createElement Paper,{
          "circle": true
          "style":{
            "width": D
            "height": D
            "top": M
            "left": M#D/2+M
            #marginTop: 2*M
            #marginBottom: M
            #float: 'right'
            "position": 'absolute'
            "display": 'inline'
          }
          "zDepth": 5
        }
        ->
          React.createElement Avatar,{
            "style":{
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
      linktohere = that.props?.user?.links?.in?[linkstate.store that.props.from]?
      if linktohere
        inLinks = that.props.user.links.in[linkstate.store that.props.from]
        n = 0
        #LinksArrayByWeight = linkstate.sortByWeight(inLinks, that.props.howMany)
        loopDirection =
          INLINKS: linkstate.sortByWeight(that.props.user.links.in[linkstate.store that.props.from], that.props.howMany)
          OUTLINKS: linkstate.sortByWeight(that.props.user.links.out[linkstate.store that.props.from], that.props.howMany)
        loopDict =
          INLINKS: that.props.user.links.in[linkstate.store that.props.from]
          OUTLINKS: that.props.user.links.out[linkstate.store that.props.from]
        for direction, LinksArrayByWeight of loopDirection
          n=0
          for key, mark of LinksArrayByWeight
            target = loopDict[direction][mark] #inLinks[mark]
            dictWeight = target.meta.weight
            lastKey = LinksArrayByWeight[key-1]
            lastVectorExist = loopDict?[direction]?[lastKey]?.meta?.weight?
            lastVector = loopDict[direction][lastKey] if lastVectorExist
            if lastVectorExist and lastVector.meta.weight is target.meta.weight
              n++
            else
              n = 0
            markprops =
              user: that.props.user
              ScreenshotUrl: that.props.ScreenshotUrl
              n: n
              target: target
              weight: target.meta.weight
              measurements: that.props.styles.measurements
              styles: that.props.styles
              direction: direction
            React.createElement yourMark, markprops


yourMark = React.createClass
  render: ->
    that = this
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

    # reactKup (k) ->
    React.createElement Paper,{
      "circle": true
      "style":{
        "position": 'absolute'
        "top": Position
          "measurements": measurements
          "weight": weight
          "n": n
          "directed": that.props.direction
          "axis": 'y'
        "left": Position
          "measurements": measurements
          "weight": weight
          "n": n
          "directed": that.props.direction
          "axis": 'x'
        "width": r
        "height": r
      }
      "zDepth": shadowFloor body, 5 , 50
    }
    #overflow: 'hidden'
    ->
      text = Lo.get that.props, 'target.meta.body'
      {direction} = that.props
      {ScreenshotUrl, ScreenshotUrlTo} = that.props.target.meta
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
            "src": if direction is "OUTLINKS" then ScreenshotUrlTo else ScreenshotUrl
          }
#exports.yourMark = yourMark
#exports.shadowMoon = shadowMoon
