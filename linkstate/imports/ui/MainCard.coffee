reactKup = require('react-kup')
React = require('react')
{style} = require('../ui/style.coffee')
{changeQueryParams, changeQueryParamsObject} = require('../api/changeQueryParams.coffee')
{FromToSense} = require('../ui/FromToSense.coffee')
Card = require('material-ui/lib/card/card').default
CardActions = require('material-ui/lib/card/card-actions' ).default
CardHeader = require('material-ui/lib/card/card-header').default
CardMedia = require('material-ui/lib/card/card-media').default
CardTitle = require('material-ui/lib/card/card-title').default
FlatButton = require('material-ui/lib/flat-button' ).default
CardText =  require('material-ui/lib/card/card-text').default
IconButton = require('material-ui/lib/icon-button').default
Flip =  require('material-ui/lib/svg-icons/communication/swap-calls').default
ExitToPage =  require('material-ui/lib/svg-icons/action/exit-to-app').default
ContentCopy =  require('material-ui/lib/svg-icons/content/content-copy').default
Print =  require('material-ui/lib/svg-icons/action/print').default
Edit =  require('material-ui/lib/svg-icons/editor/mode-edit').default
FromIcon =  require('material-ui/lib/svg-icons/communication/call-received').default
ToIcon =  require('material-ui/lib/svg-icons/communication/call-made').default
`import ReactDOM from 'react-dom';`
`import {CopyToClipboard} from 'react-copy-to-clipboard';`
`import copy from 'copy-to-clipboard';`
Lo = require 'lodash'

{shadowMoon} = require '../ui/ShadowMoon'
exports.MainCard = React.createClass
  getDefaultProps: ->
    expanded: true
  componentDidMount: ->
    focusTextbox = () ->
      select = document.activeElement.type is 'text'
      text = document.activeElement.id is 'textAbout'
      unless select or text
        if false is true and window?.textAbout?.refs?.MainCardTextInput?.focus()
          window.textAbout.refs.MainCardTextInput.focus()
          #$('#textAbout').focus()
        console.log document.activeElement.id, document.activeElement.type
    #setInterval(focusTextbox,650)
  render: ->
    that = this
    if that?.props?.user?.out?.Bookmarks?[ linkstate.store that.props.from]?
      HERE = that.props.user.links.out.Bookmarks[ linkstate.store that.props.from]
      ScreenshotUrl = HERE.meta.ScreenshotUrl if HERE?.meta?
    else HERE =
      title: that.props.lastTitle
      from: that.props.from
    if that?.props?.user?.out?.Bookmarks?[ linkstate.store that.props.to]?
      THERE = that.props.user.links.out.Bookmarks[ linkstate.store that.props.to]
      ThereScreenshotUrl = Lo.get that.props, 'user.out.Bookmarks.'+linkstate.store(that.props.to)
    reactKup (k) ->
      k.build Card, # build the Card component
        expanded: that.props.expanded # add argument key value pairs
        style: _.extend {}, style.card, style.mCard,
          overflow: 'hidden'
        ->
          k.build CardHeader,
            title: HERE.title,
            subtitle: that.props.word.MainCardSubtitle
            showExpandableButton: false
            onClick: (e) ->
              window.open HERE.meta.FromLink
          k.build CardMedia,
            style: style.overlayPercentage
            onClick: (e) ->
              win = window.open(decodeURIComponent HERE.from, '_blank')
              win.focus()
          k.build CardText,
            style:
              overflow: 'hidden'
            ->
              k.build FromToSense,
                from: that.props.from
                to: that.props.to
                lastTitle: that.props.lastTitle
                word: that.props.word
                content: that.props.content
                user: that.props.user
                newHere: that.props.newHere
              k.build shadowMoon,
                measurements:
                  D: 80
                  d: 80
                  M: 150
                ScreenshotUrl: ThereScreenshotUrl
                styler:
                  marginLeft: -20# -100
                  marginTop: -200
                  #display: 'block'
                  opacity: .5
                  position: 'absolute'
          k.build CardActions,
            ->
              k.build IconButton,
                tooltip: "Copy to clipboard because sharing -> " + window.location.href
                tooltipPosition: 'bottom-right'
                onClick: (e) ->
                  copy window.location.href
                ->
                  k.build ContentCopy
              k.build IconButton,
                tooltip: "Reverse - Point TO what you're now pointing FROM"
                tooltipPosition: 'bottom-right'
                ref: 'blurer'
                onFocus: () ->
                  window.textAbout.refs.MainCardTextInput.focus()
                onClick: () ->
                  changeQueryParamsObject
                    from: that.props.to
                    to: that.props.from
                ->
                  k.build Flip
              k.build IconButton,
                tooltip: "TO - Visit the page you're connecting TO " + that.props.to
                tooltipPosition: 'bottom-right'
                onClick: () ->
                  window.open that.props.to
                ->
                  k.build ToIcon
              k.build IconButton,
                tooltip: "FROM - Visit the page you're looking FROM "+that.props.from
                tooltipPosition: 'bottom-right'
                onClick: () ->
                  window.open that.props.from
                ->
                  k.build FromIcon
              k.build IconButton,
                tooltip: "Rich editing and markup of the page. Quote it for your notes. Screenshot a part perhaps?"
                tooltipPosition: 'bottom-right'
                style:
                  opacity: .4
                onClick: () ->
                  window.open that.props.to
                ->
                  k.build Edit
              k.build IconButton,
                #style:
                #  height: 0
                tooltip: "Archive the whole page for me. Request this or other features if you need it."
                tooltipPosition: 'bottom-right'
                ref: 'blurer4'
                style:
                  opacity: .4
                onFocus: () ->
                  window.textAbout.refs.MainCardTextInput.focus()
                onClick: () ->
                  window.open that.props.to
                ->
                  k.build Print
              k.build IconButton,
                #style:
                #  height: 0
                tooltip: "What are people tweeting about this?"
                tooltipPosition: 'bottom-right'
                ref: 'blurerTweet'
                style:
                  opacity: .4
                onFocus: () ->
                  window.textAbout.refs.MainCardTextInput.focus()
                onClick: () ->
                  # request feature by connecting to it....
                  ###
                  payload =
                    from: that.props.user.services.facebook.link
                    to: "http://youiest.com/features/socialStats"
                  console.log payload
                  changeQueryParamsObject payload
                  ###
                  window.open 'linkstate.youiest.com'
                ->
                  k.build Print
