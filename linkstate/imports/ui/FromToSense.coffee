#reactKup = require('react-kup')
{style} = require '../ui/style.coffee'
# SimpleSelect = require("react-selectize").SimpleSelect
React = require 'react'
{changeQueryParams} = require '../api/changeQueryParams.coffee'
# ui object calling a container.. not great?
selectedContainer = require('../api/Selected.coffee').selectedContainer
# {see} = require '../api/strings.coffee'
TextField = require('material-ui/lib/TextField').default #not working @material-ui/core/TextField
{Slider} = require './Slider'


{div, a,} = React.DOM

exports.FromToSense = React.createClass
  render: ->
    that = this
    div
      "style": _.extend {}
      React.createElement TextAbout,
        "word": that.props.word
        "type": 'MainCardTextInput'
        "content": that.props.content
        weight: @props.hereToThereObjWeight
      div
        "style":
          "maxWidth": '100%'
          "whiteSpace": "nowrap"
        React.createElement selectedContainer,
          "from": that.props.from
          "to": that.props.to
          "lastTitle": that.props.lastTitle
          "user": that.props.user
          "word": that.props.word
          "type": 'to'

TextAbout = React.createClass
  componentWillReceiveProps: ->
    if FlowRouter.getQueryParam('switched') is 'true'
      @refs.MainCardTextInput.input.setValue(@props.content)
      changeQueryParams('switched','')
  onUpdate: (weight) =>
    content = {}
    content.body = $("#textAbout").val() # e.target.value #FlowRouter.getQueryParam('content')
    # weight is between 0 and 9
    payload =
      from: FlowRouter.getQueryParam('from')
      to: FlowRouter.getQueryParam('to')
      meta: content
    content.weight = weight || 0 # e.keyCode - 48
    Meteor.defer ->
      Meteor.call "Linking", payload, (error, result) ->
        if error
          console.log "error", error
        if result?
          console.log result, 'returned from linking'
        else
          console.log 'no result?', result
  onChangeWeight: (event, value)->
    this.onUpdate(value);

  render: ->
    onChangeWeight = this.onChangeWeight.bind(this);
    onUpdate = this.onUpdate.bind(this);
    window.textAbout = this
    that = this
    # #reactKup (k) ->
    div
      className: "xyz"
      React.createElement TextField,
        "ref": 'MainCardTextInput'
        "autoFocus": true
        onSelect: (e) ->
          if e.target.value.length < 1
            e.target.value = that.props.content
        onKeyDown: (e) ->
          if 48 <= e.keyCode <= 57 and !e.ctrlKey and !e.shiftKey and !e.altKey
            #changeQueryParams 'content', ''
            onUpdate(e.keyCode - 48);
            e.preventDefault()
            #window.to.refs.to.focus() if window?.to?.refs?
          else
            changeQueryParams 'content', e.target.value
          if e.keyCode is 13
            alert that.props.word.digitAlert
            e.preventDefault()
        onKeyUp: (e) ->
          updatedContent = e.target.value.replace(/\d+/g, '')
          changeQueryParams 'content', updatedContent
        floatingLabelText: that.props.word.TextAboutfloatingLabelText
        multiLine: true
        rows: 2
        id: 'textAbout'
        hintText: that.props.word.TextAboutHintText
        defaultValue: that.props.content
        style:
          width: '100%'
          tabIndex: 0
          paddingLeft: 4
          marginRight: 7
          bottom: 9
      React.createElement Slider, {
        step: that ? that.props ? that.props.meta ? that.props.meta.weight || 0,
        onChangeWeight: onChangeWeight
        meta: that.props.meta
        weight: that.props.weight
      }
