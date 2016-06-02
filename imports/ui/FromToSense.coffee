reactKup = require('react-kup')
{style} = require '../ui/style.coffee'
SimpleSelect = require("react-selectize").SimpleSelect
React = require 'react'
{changeQueryParams} = require '../api/changeQueryParams.coffee'
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
          content: that.props.content
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
              from: that.props.from
              to: that.props.to
              type: 'to'

TextAbout = React.createClass
  onKeyUp: (e) ->
    console.log e.keyCode, e.target.value

    if e.keyCode is 13
      Meteor.call 'Linking'
      , FlowRouter.getQueryParam('from')
      , FlowRouter.getQueryParam('to')
      , FlowRouter.getQueryParam('content')
    else
      changeQueryParams 'content', e.target.value
      console.log FlowRouter.getQueryParam('content')
  render: ->
    window.textAbout = this
    that = this
    reactKup (k) ->
      k.build TextField,
        ref: 'MainCardTextInput'
        onKeyUp: that.onKeyUp
        style:
          width: '100%'
          tabIndex: 0
          paddingLeft: 4
          marginRight: 7
          bottom: 9
        floatingLabelText: that.props.word.TextAboutfloatingLabelText
        id: 'textAbout'
        hintText: that.props.word.TextAboutHintText
        defaultValue: that.props.content
