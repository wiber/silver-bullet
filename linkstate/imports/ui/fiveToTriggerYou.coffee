React = require 'react'
IconButton = require('material-ui/lib/icon-button').default #@material-ui/core/IconButton not working
RaisedButton = require('material-ui/lib/raised-button').default
TextField = require('material-ui/lib/TextField').default
{div, br, span,a} = React.DOM

exports.fiveToTriggerYou = React.createClass
  render: ->
    console.log {@props}

    style =
      margin: 0
    if @props?.user?.services?#@state.isLoggedIn # @props?.props?.user
      div
        className: 'container'
          div
            className: 'row'
            div
              className: ''
              #React.createElement 
