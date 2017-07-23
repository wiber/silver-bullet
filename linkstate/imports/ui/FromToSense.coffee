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
              lastTitle: that.props.lastTitle
              user: that.props.user
              word: that.props.word
              type: 'to'

TextAbout = React.createClass
  componentWillReceiveProps: ->
    if FlowRouter.getQueryParam('switched') is 'true'
      @refs.MainCardTextInput.input.setValue(@props.content)
      changeQueryParams('switched','')
  render: ->
    window.textAbout = this
    that = this
    reactKup (k) ->
      k.build TextField,
        ref: 'MainCardTextInput'
        autoFocus: true
        onSelect: (e) ->
          if e.target.value.length < 1
            e.target.value = that.props.content
        onKeyDown: (e) ->
          if 48 <= e.keyCode <= 57 and !e.ctrlKey and !e.shiftKey and !e.altKey
            content = {}
            content.body = e.target.value #FlowRouter.getQueryParam('content')
            # weight is between 0 and 9
            payload =
              from: FlowRouter.getQueryParam('from')
              to: FlowRouter.getQueryParam('to')
              meta: content
            content.weight = e.keyCode - 48
            Meteor.defer ->
              Meteor.call "Linking", payload, (error, result) ->
                if error
                  console.log "error", error
                if result?
                  console.log result, 'returned from linking'
                else
                  console.log 'no result?', result
            #changeQueryParams 'content', ''
            e.preventDefault()
            window.to.refs.to.focus()
          else
            changeQueryParams 'content', e.target.value
          if e.keyCode is 13
            alert that.props.word.digitAlert
            e.preventDefault()
        onKeyUp: (e) ->
          updatedContent = e.target.value.replace(/\d+/g, '')
          changeQueryParams 'content', updatedContent
        style:
          width: '100%'
          tabIndex: 0
          paddingLeft: 4
          marginRight: 7
          bottom: 9
        floatingLabelText: that.props.word.TextAboutfloatingLabelText
        multiLine: true
        rows: 2
        id: 'textAbout'
        hintText: that.props.word.TextAboutHintText
        defaultValue: that.props.content
