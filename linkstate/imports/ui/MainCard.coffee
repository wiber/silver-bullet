reactKup = require('react-kup')
React = require('react')
{style} = require('../ui/style.coffee')
{hereAndThere} = require('../api/ModelOperations.coffee')
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
ShareFacebookButton =  require('material-ui/lib/svg-icons/action/print').default
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
  render: ->
    that = this
    {HERE, HereScreenshotUrl, THERE, ThereScreenshotUrl} = hereAndThere that.props.user, that.props
    #console.log THERE, ThereScreenshotUrl,'THERE, ThereScreenshotUrl', Lo.get that.props, 'user.links.in.Bookmarks'
    # reactKup (k) ->
    div
      className: 'hasten'
      React.createElement Card, { "style": _.extend {}, style.card, style.mAcard },#"expanded": that.props.expanded, 
        React.createElement CardHeader, {
          "title": HERE.title
          "subtitle": that.props.word.MainCardSubtitle
          onClick: -> 
            window.open HERE.meta.FromLink
        }
        React.createElement CardMedia, {
          "style": style.overlayPercentage
          onClick: -> 
            win = window.open(decodeURIComponent HERE.from, '_blank')
            win.focus()
        }
        React.createElement CardText, {
          "style": _.extend {},
            overflow: 'hidden'
        },
          React.createElement FromToSense, {
            "from": that.props.from
            "to": that.props.to
            "lastTitle": that.props.lastTitle
            "word": that.props.word
            "content": that.props.content
            "user": that.props.user
            "newHere": that.props.newHere
          }
          React.createElement shadowMoon, {
            "measurements":
              "D": 80
              "d": 80
              "M": 150
            "ScreenshotUrl": ThereScreenshotUrl
            "styler":
              "marginLeft": -20# -100
              "marginTop": -200
              "opacity": .5
              "position": 'absolute'
          }
        React.createElement CardActions, {
          "style": _.extend {},
        },
          React.createElement IconButton, {
            "tooltip": "Copy to clipboard because sharing -> " + window.location.href
            "tooltipPosition": 'bottom-right'
            onClick: -> 
              copy window.location.href
          },
            React.createElement ContentCopy, {
              "style": _.extend {},
            }
          React.createElement IconButton, {
            "tooltip": "Reverse - Point TO what you're now pointing FROM"
            "tooltipPosition": 'bottom-right'
            "ref": 'blurer'
            onFocus: ->
              window.textAbout.refs.MainCardTextInput.focus()
            onClick: ->
              changeQueryParamsObject
                from: that.props.to
                to: that.props.from
          },
            React.createElement Flip, {
              "style": _.extend {},
            }
          React.createElement IconButton, {
            "tooltip": "TO - Visit the page you're connecting TO " + that.props.to
            "tooltipPosition": 'bottom-right'
            onClick: ->
              window.open that.props.to
          },
            React.createElement ToIcon, {
              "style": _.extend {},
            }
          React.createElement IconButton, {
            "tooltip": "FROM - Visit the page you're looking FROM "+that.props.from
            "tooltipPosition": 'bottom-right'
            onClick: ->
              window.open that.props.from
          },
            React.createElement ToIcon, {
              "style": _.extend {},
            }
          React.createElement IconButton, {
            "tooltip": "Rich editing and markup of the page. Quote it for your notes. Screenshot a part perhaps?"
            "tooltipPosition": 'bottom-right'
            "style":
                "opacity": .4
            onClick: ->
              window.open that.props.to
          },
            React.createElement Edit, {
              "style": _.extend {},
            }
          React.createElement IconButton, {
            "tooltip": "Archive the whole page for me. Request this or other features if you need it."
            "tooltipPosition": 'bottom-right'
            "ref": 'blurer4'
            "style":
                "opacity": .4
            onFocus: ->
              window.textAbout.refs.MainCardTextInput.focus()
            onClick: ->
              changeQueryParamsObject ->
                window.open that.props.to
          },
            React.createElement Print, {
              "style": _.extend {},
            }
          React.createElement IconButton, {
            "tooltip": "What are people tweeting about this?"
            "tooltipPosition": 'bottom-right'
            "ref": 'blurerTweet'
            "style":
                "opacity": .4
            onFocus: ->
              window.textAbout.refs.MainCardTextInput.focus()
            onClick: ->
              window.open 'linkstate.youiest.com'
          },
            React.createElement Print, {
              "style": _.extend {},
            }
