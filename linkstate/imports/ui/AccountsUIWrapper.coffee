React = require 'react'
reactKup = require('react-kup')
exports.AccountsUIWrapper = React.createClass
  componentDidMount: ->
    @view = Blaze.render Template.loginButtons, document.getElementById 'loginContainer'

  #componentWillUnmount: ->
  #  Blaze.remove @view
  render: ->
    
    that = this
    reactKup (k) ->
      k.span
        tabIndex: -1
        ref: 'container'
        id: 'loginContainer'
