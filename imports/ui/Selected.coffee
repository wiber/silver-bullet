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
  componentDidUpdate: ->
    try
      window.textAbout.refs.MainCardTextInput.focus()
    catch error
      console.error error
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
          maxWidth: '50%' #150
        theme: "material"# // can be one of "default" | "bootstrap3" | "material" | ...
        transitionEnter: true
        onValueChange: (val) ->
          #console.log val, val.value?, val.value.meta.FromLink?
          if val.value.meta.FromLink
            changeQueryParams that.props.type, val.value.meta.FromLink
        value: that.props.value
        ###_.find that.props.options, (obj) ->
          obj.value.meta.FromLink == that.props[that.props.type]
          # TODO could store entire object here for richer list Layout
          # obj.value.link = plain url link from props...###
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
