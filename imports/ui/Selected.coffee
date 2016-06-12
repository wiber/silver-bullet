{style} = require '../ui/style.coffee'
reactKup = require('react-kup')
SimpleSelect = require("react-selectize").SimpleSelect
React = require 'react'
{changeQueryParams} = require('../api/changeQueryParams.coffee')
{see, store} = require '../api/strings.coffee'
Selected = React.createClass
  propTypes: (props) ->
    from: React.propTypes.string
    to: React.propTypes.string
    type: React.propTypes.string
    options: React.propTypes.array
  render: ->
    that = this
    defaultValue = _.find that.props.options, (obj) ->
      obj.value == that.props[that.props.type]
    console.log defaultValue, @props.options, @props[@props.type], @props.type
    window[that.props.type] = this
    reactKup (k) ->
      k.build SimpleSelect,
        maxValues: 1
        style:
          overflow: 'hidden'
          display: 'inline-block'
          #textOverflow: "ellipsis"
          whiteSpace: "nowrap"
          maxWidth: '50%' #150
        theme: "material"# // can be one of "default" | "bootstrap3" | "material" | ...
        transitionEnter: true
        onValueChange: (val) ->
          if val.value
            changeQueryParams that.props.type, val.value
        defaultValue: _.find that.props.options, (obj) ->
          obj.value == that.props[that.props.type]
        ref: that.props.type
        id: that.props.type
        options: that.props.options
        tabIndex: if that.props.type is 'from' then '2' else '3'
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
                maxWidth: '87%'
              item.label

exports.Selected = Selected
