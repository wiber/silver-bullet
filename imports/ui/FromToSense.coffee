reactKup = require('react-kup')
{style} = require '../ui/style.coffee'
SimpleSelect = require("react-selectize").SimpleSelect
React = require 'react'

# ui object calling a container.. not great?
selectedContainer = require('../api/Selected.coffee').selectedContainer

TextField = require('material-ui/lib/TextField').default
exports.FromToSense = React.createClass
  render: ->
    that = this
    reactKup (k) ->
      k.div ->
        k.build TextAbout,
          word: that.props.word
          type: 'MainCardTextInput'
        k.div
          style:
            maxWidth: '100%'
            whiteSpace: "nowrap"
          ->
            k.build selectedContainer,
              from: that.props.from
              to: that.props.to
              type: 'from'
            k.span
              style:
                verticalAlign: '0.5em'
              ' to '
            k.build selectedContainer,
              to: that.props.to
              from: that.props.from
              type: 'to'
TextAbout = React.createClass
  render: ->
    window.textAbout = this
    that = this
    reactKup (k) ->
      k.build TextField,
        ref: 'MainCardTextInput'
        style:
          width: '100%'
          tabIndex: 0
          paddingLeft: 4
          marginRight: 7
          bottom: 9
        floatingLabelText: that.props.word.TextAboutfloatingLabelText
        id: 'textAbout'
        hintText: that.props.word.TextAboutHintText
