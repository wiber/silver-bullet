React = require 'react'
IconButton = require('material-ui/lib/icon-button').default #@material-ui/core/IconButton not working
RaisedButton = require('material-ui/lib/raised-button').default
TextField = require('material-ui/lib/TextField').default
{div, br, span} = React.DOM

exports.Login = React.createClass
  getInitialState: ->
    isLoggedIn: false,
    name: ""

  componentDidMount: ->
    self = this;
    setTimeout ()->
      user = Meteor.user();
      isLoggedIn = false
      if user
        isLoggedIn = true

      # self.setState {
      #   name: user?user.profile?user.profile.name || ""
      #   isLoggedIn: isLoggedIn
      # }
    ,5000

  onLoginWithFacebook: () ->
    console.log "onLoginWithFacebook"

  onLoginWithLinkedIn: () ->
    console.log "onLoginWithLinkedIn"

  onLogin: () ->
    console.log "onLogin"

  onRegister: () ->
    console.log "onRegister"

  onLogout: () ->
    # Meteor.logout(()->{})
    console.log "onLogout"

  render: ->

    onLoginWithFacebook = this.onLoginWithFacebook.bind(this)
    onLoginWithLinkedIn = this.onLoginWithLinkedIn.bind(this)
    onLogin = this.onLogin.bind(this)
    onRegister = this.onRegister.bind(this)
    onLogout = this.onLogout.bind(this)

    style = {
      margin: 2
    }

    if this.state.isLoggedIn
      div
        className: 'container'
          div
            className: 'row'
            div
              className: 's12'
              React.createElement RaisedButton, {
                label: "Logout",
                secondary: true,
                style: style,
                onMouseDown: onLogout
              }
    else
      div
        className: 'container'
        div
          className: 'row'
          div
            className: 's12'
            React.createElement RaisedButton, {
              label: "Login with Facebook",
              primary: true,
              style: style,
              onMouseDown: onLoginWithFacebook
            }
            React.createElement RaisedButton, {
              label: "Login with LinkedIn",
              primary: true,
              style: style,
              onMouseDown: onLoginWithLinkedIn
            }
        div
          className: 'row'
          div
            className: "s6"
            React.createElement TextField, {
              hintText: "john@example.com"
            }
          div
            className: "s6"
            React.createElement TextField, {
              hintText: "password"
            }
          div
            className: "s12"
            React.createElement RaisedButton, {
              label: "Login",
              primary: true,
              style: style,
              onMouseDown: onLogin
            }
            React.createElement RaisedButton, {
              label: "Register",
              primary: true,
              style: style,
              onMouseDown: onRegister
            }
        # div
        #   className: 'row'
        #   div
        #     className: "s6"
        #     React.createElement TextField, {
        #       hintText: "john@example.com"
        #     }
        #   div
        #     className: "s6"
        #     React.createElement TextField, {
        #       hintText: "password"
        #     }
        #   div
        #     className: "12"
        #     React.createElement RaisedButton, {
        #       label: "Register",
        #       primary: true,
        #       style: style
        #     }
        #     React.createElement RaisedButton, {
        #       label: "Login",
        #       primary: true,
        #       style: style
        #     }
