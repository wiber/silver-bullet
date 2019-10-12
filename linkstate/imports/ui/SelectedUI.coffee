{style} = require '../ui/style.coffee'
#reactKup = require('react-kup')
SimpleSelect = require("react-selectize").SimpleSelect
React = require 'react'
{changeQueryParams} = require('../api/changeQueryParams.coffee')
# {see, store} = require '../api/strings.coffee'
IconButton = require('material-ui/lib/icon-button').default #not working @material-ui/core/IconButton
FromIcon =  require('material-ui/lib/svg-icons/communication/call-received').default #not in material-ui default-@material-ui/core/Icon
ToIcon =  require('material-ui/lib/svg-icons/communication/call-made').default #not in material-ui

Selected = React.createClass
  propTypes: (props) ->
    from: React.propTypes.string
    to: React.propTypes.string
    type: React.propTypes.string
    options: React.propTypes.array
    word: Rect.propTypes.object
  componentDidUpdate: ->
    try
      window.textAbout.refs.MainCardTextInput.focus()
    catch error
      console.error error
  render: ->
    window[@props.type] = this
    if @props.type is 'from'
      tooltipText = @props.word.FromTooltipText
    else
      tooltipText = @props.word.ToTooltipText
    that = this
    # #reactKup (k) ->
    div
      ref: 'dadiv'
      "style": {
        "overflow": 'hidden'
        "textOverflow": "ellipsis"
        "whiteSpace": "nowrap"
      }
      #if  that.props.value.label is 'string' # undefined first time?
      React.createElement SimpleSelect,{
        "maxValues": 1
        "theme": "material"
        "transitionEnter": true
        "value": that.props.value
        "ref": 'selecters'
        "id": that.props.type
        options: that.props.options #error here
        "tabindex": if that.props.type is 'from' then '2' else '3'
        "tether": true
        "tetherProps":
          "attachment": 'top center'
          "targetAttachment": 'bottom center'
        "hideResetButton": true
        "style": {
          "overflow": 'hidden'
          "display": 'absolute'
          "whiteSpace": "nowrap"
          "maxWidth": '92%' #150
          "minWidth": '89%'
          "left": '11%'
        }
        onBlur: () ->
          window.textAbout.refs.MainCardTextInput.focus()
        onValueChange: (val) ->
          if val.value.meta.FromLink
            changeQueryParams that.props.type, val.value.meta.FromLink
        renderValue: (item) ->
          span
            style:
              "textOverflow": "ellipsis"
              "position": 'absolute'
              "bottom": '0.4em'
              "display": 'inline-block'
              "overflow": "hidden"
              "whiteSpace": 'nowrap'
              "textAling": 'top'
            item.value.meta.title
          }

        React.createElement IconButton,
          tooltip: tooltipText
          tooltipPosition: 'bottom'
          ref: 'blurer'
          style:
            position: 'absolute'
            marginTop: '-35px'
          onFocus: () ->
            window.textAbout.refs.MainCardTextInput.focus()
            that.refs.blurer.refs.tooltip.setState
              show: false
          ->
            if that.props.type is 'to'
              React.createElement ToIcon
            else
              React.createElement FromIcon


exports.Selected = Selected
