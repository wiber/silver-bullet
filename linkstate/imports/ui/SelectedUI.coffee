{style} = require '../ui/style.coffee'
#reactKup = require('react-kup')
SimpleSelect = require("react-selectize").SimpleSelect
React = require 'react'
{changeQueryParams} = require('../api/changeQueryParams.coffee')
{see, store} = require '../api/strings.coffee'
IconButton = require('material-ui/lib/icon-button').default
FromIcon =  require('material-ui/lib/svg-icons/communication/call-received').default
ToIcon =  require('material-ui/lib/svg-icons/communication/call-made').default
{catTree} = require('../api/strings').linkstate

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
      style:
        overflow: 'hidden'
        textOverflow: "ellipsis"
        whiteSpace: "nowrap"
      React.createElement SimpleSelect,{
        maxValues: 1
        theme: "material"
        transitionEnter: true
        value: that.props.value
        ref: 'selecters'
        id: that.props.type
        options: that.props.options
        tabindex: if that.props.type is 'from' then '2' else '3'
        tether: true
        tetherProps:
          attachment: 'top center'
          targetAttachment: 'bottom center'
        onValueChange: (val) ->
          # this is the problem. use the user object instead of queryParams for state
          # always and everywhere where it's having with the actual app to do
          # how do we update user when we are from (switchedPlace)
          if val.value.meta.FromLink
            #changeQueryParams that.props.type, val.value.meta.FromLink
            payload =
              from: val.value.meta.FromLink
              to: catTree.categoryUrls[that.props.type] # to usually..
              meta:
                title: new Date().getTime() + ' changed Select'
            # we only point to places and swap pointing for being from now
            # TODO rewrite swap  button. swap model.
            # some way to check if we have new queryParamsState is needed.
            Meteor.call 'Linking', payload, (error, result) ->
              console.log error, result, 'categorySelect', that.props.type, payload


        hideResetButton: true
        style:
          overflow: 'hidden'
          display: 'absolute'
          whiteSpace: "nowrap"
          maxWidth: '92%' #150
          minWidth: '89%'
          left: '11%'
        onBlur: () ->
          window.textAbout.refs.MainCardTextInput.focus()
        renderValue: (item) ->
          span
            style:{
              textOverflow: "ellipsis"
              position: 'absolute'
              bottom: '0.4em'
              display: 'inline-block'
              overflow: "hidden"
              whiteSpace: 'nowrap'
              textAlign: 'top'
            }
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
