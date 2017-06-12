{style} = require '../ui/style.coffee'
reactKup = require('react-kup')
SimpleSelect = require("react-selectize").SimpleSelect
React = require 'react'
{changeQueryParams} = require('../api/changeQueryParams.coffee')
{see, store} = require '../api/strings.coffee'
IconButton = require('material-ui/lib/icon-button').default
FromIcon =  require('material-ui/lib/svg-icons/communication/call-received').default
ToIcon =  require('material-ui/lib/svg-icons/communication/call-made').default

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
      tooltipText = @props.word.FromTooltipText# "Pointing FROM here, where you are now."
    else
      tooltipText = @props.word.ToTooltipText # "Pointing TO there, the place we're saying something about."
    that = this
    reactKup (k) ->
      k.div
        ref: 'dadiv'
        style:
          overflow: 'hidden'
          textOverflow: "ellipsis"
          whiteSpace: "nowrap"
        ->
          k.build SimpleSelect,
            maxValues: 1
            style:
              overflow: 'hidden'
              display: 'absolute'
              whiteSpace: "nowrap"
              maxWidth: '92%' #150
              minWidth: '89%'
              left: '11%'
            theme: "material"
            onBlur: () ->
              window.textAbout.refs.MainCardTextInput.focus()
            transitionEnter: true
            onValueChange: (val) ->
              if val.value.meta.FromLink
                changeQueryParams that.props.type, val.value.meta.FromLink
            value: that.props.value
            ref: 'selecters'
            id: that.props.type
            options: that.props.options
            tabindex: if that.props.type is 'from' then '2' else '3'
            tether: true #!!window #true # else ssr error
            tetherProps:
              #offset: '-20% -20%' # does nothing, why?
              attachment: 'top center'
              #'target-attachment': 'bottom center'
              targetAttachment: 'bottom center'
              #target: -> window.textAbout
            hideResetButton: true
            renderValue: (item) ->
              reactKup (k) ->
                k.span
                  style:
                    textOverflow: "ellipsis"
                    position: 'absolute'
                    bottom: '0.4em'
                    display: 'inline-block'
                    overflow: "hidden"
                    whiteSpace: 'nowrap'
                    textAling: 'top'
                    #maxWidth: '87%'
                  item.label
          k.build IconButton,
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
                # .hide()#props.style.visibility = 'hidden'
            onClick: () ->
              changeQueryParamsObject
                from: that.props.to
              changeQueryParamsObject
                to: that.props.from
            ->
              if that.props.type is 'to'
                k.build ToIcon
              else
                k.build FromIcon


exports.Selected = Selected
