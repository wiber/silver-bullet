React = require 'react'
IconButton = require('material-ui/lib/icon-button').default #@material-ui/core/IconButton not working
RaisedButton = require('material-ui/lib/raised-button').default
TextField = require('material-ui/lib/TextField').default
{div, br, span} = React.DOM

exports.Login = React.createClass
  getInitialState: ->
    isLoggedIn: Meteor.userId(),
    name: ""

  componentDidMount: ->
    self = this;

  onLoginWithFacebook: () ->
    console.log "onLoginWithFacebook"
    Meteor.loginWithFacebook ()->
      console.log Meteor.userId()

  onLoginWithLinkedIn: () ->
    console.log "onLoginWithLinkedIn"
    Meteor.loginWithLinkedin ["r_emailaddress", "r_liteprofile"], ()->
      console.log Meteor.userId()

  onLogin: () ->
    console.log "onLogin"
    userLogin = {
      email: @refs.email.getValue(),
      password: @refs.password.getValue()
    }
    if @validate(userLogin)
      Meteor.loginWithPassword userLogin.email, userLogin.password, ()->
        console.log Meteor.userId()

  onRegister: () ->
    console.log "onRegister"
    registerLogin = {
      email: @refs.email.getValue(),
      password: @refs.password.getValue()
    }
    if @validate(registerLogin)
      Accounts.createUser registerLogin, ()->
        console.log Meteor.userId()

  onLogout: () ->
    console.log "onLogout"
    Meteor.logout ()->
      console.log Meteor.userId()

  validate: (userInfo)->
    if userInfo.email && userInfo.password
      true
    else
      console.log "Invalid information."

  render: ->
    # console.log(this.props.props.user);
    # onLoginWithFacebook = this.onLoginWithFacebook.bind(this)
    # onLoginWithLinkedIn = this.onLoginWithLinkedIn.bind(this)
    # onLogin = this.onLogin.bind(this)
    # onRegister = this.onRegister.bind(this)
    # onLogout = this.onLogout.bind(this)

    style = {
      margin: 2
    }
    #console.log {@props},@props.props.user?
    if @props?.user?.services?#@state.isLoggedIn # @props?.props?.user
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
                onMouseDown: @onLogout
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
              onMouseDown: @onLoginWithFacebook
            }
            React.createElement RaisedButton, {
              label: "Login with LinkedIn",
              primary: true,
              style: style,
              onMouseDown: @onLoginWithLinkedIn
            }
        div
          className: 'row'
          div
            className: "s6"
            React.createElement TextField, {
              hintText: "john@example.com",
              ref: "email"
            }
          div
            className: "s6"
            React.createElement TextField, {
              hintText: "password",
              ref: "password",
              type: "password"
            }
          div
            className: "s12"
            React.createElement RaisedButton, {
              label: "Login",
              primary: true,
              style: style,
              onMouseDown: @onLogin
            }
            React.createElement RaisedButton, {
              label: "Register",
              primary: true,
              style: style,
              onMouseDown: @onRegister
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
