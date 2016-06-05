reactKup = require('react-kup')
{style} = require '../ui/style.coffee'
SimpleSelect = require("react-selectize").SimpleSelect
React = require 'react'
{changeQueryParams} = require '../api/changeQueryParams.coffee'
# ui object calling a container.. not great?
selectedContainer = require('../api/Selected.coffee').selectedContainer
{see} = require '../api/strings.coffee'
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
    write = () ->
      content = {}
      content.body = FlowRouter.getQueryParam('content')
      content.weight = e.keyCode - 48
      Meteor.call 'Linking'
      , FlowRouter.getQueryParam('from')
      , FlowRouter.getQueryParam('to')
      , content
    if 48 <= e.keyCode <= 57
      that.value = FlowRouter.getQueryParam('content').slice 0, -1
      write()
    else
      changeQueryParams 'content', e.target.value
    if e.keyCode is 13
      alert that.props.word.digitAlert

  render: ->
    window.textAbout = this
    that = this
    reactKup (k) ->
      k.build TextField,
        ref: 'MainCardTextInput'
        onKeyDown: (e) ->
          write = () ->

            content = {}
            content.body = FlowRouter.getQueryParam('content')
            # weight is between 0 and 9
            content.weight = e.keyCode - 48
            Meteor.call 'Linking'
            , FlowRouter.getQueryParam('from')
            , FlowRouter.getQueryParam('to')
            , content
          if 48 <= e.keyCode <= 57
            write()
            e.target.value = ''
            e.preventDefault()
            window.to.refs.to.focus()
          if e.keyCode is 13
            alert that.props.word.digitAlert
            e.preventDefault()
        onKeyUp: (e) ->
          e.target.value = e.target.value.replace(/\d+/g, '')
          changeQueryParams 'content', e.target.value
        style:
          width: '100%'
          tabIndex: 0
          paddingLeft: 4
          marginRight: 7
          bottom: 9
        floatingLabelText: that.props.word.TextAboutfloatingLabelText
        multiLine: true
        id: 'textAbout'
        hintText: that.props.word.TextAboutHintText
        defaultValue: that.props.content # don't let react handle queryparam encoding
        # do see that props.content causes error
