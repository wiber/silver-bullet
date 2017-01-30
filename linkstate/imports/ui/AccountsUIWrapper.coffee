React = require 'react'
reactKup = require('react-kup')
exports.AccountsUIWrapper = React.createClass
  componentDidMount: ->
    #@view = Blaze.render Template.loginButtons, document.getElementById 'loginContainer'
    #console.log @view
  #componentWillUnmount: ->
  #  Blaze.remove @view
  render: ->
    console.log 'rendered AccountsUIWrapper', @
    that = this
    reactKup (k) ->
      k.span
        tabIndex: -1
        ref: 'container'
        id: 'loginContainer'
