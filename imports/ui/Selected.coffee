reactKup = require('react-kup')
SimpleSelect = require("react-selectize").SimpleSelect
React = require 'react'
{changeQueryParams} = require('../api/changeQueryParams.coffee')
Selected = React.createClass
  propTypes: (props) ->
    from: React.propTypes.string
    to: React.propTypes.string
    type: React.propTypes.string
    options: React.propTypes.array
  queryParamChange: (val) ->
    if val.value
      changeQueryParams @props.type, val.value
  render: ->
    that = this
    window[that.props.type] = this
    reactKup (k) ->
      k.build SimpleSelect,
        maxValues: 1
        style:
          overflow: 'hidden'
          display: 'inline-block'
          #textOverflow: "ellipsis"
          whiteSpace: "nowrap"
          maxWidth: '25%' #150
        theme: "material"# // can be one of "default" | "bootstrap3" | "material" | ...
        transitionEnter: true
        onValueChange: that.queryParamChange
        defaultValue: _.find(that.props.options, (obj) ->
          obj.value == that.props[that.props.type]
        )
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
            k.div
              style:
                overflow: "hidden"
                display: 'inline-block'
                textOverflow: "ellipsis"
                whiteSpace: "nowrap"
                maxWidth:  0.15 * window.innerWidth  #+'px' #'50%' #125
              item.label

exports.Selected = Selected
