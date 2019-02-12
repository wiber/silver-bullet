React = require 'react'
reactKup = require('react-kup')


{div,nav, a, ul, li} = React.DOM

Span = React.createClass
 render: ->
   span
      tabIndex: -1
      ref: 'container'
      id: 'loginContainer'

exports.AccountsUIWrapper = React.createClass
  componentDidMount: ->
    @view = Blaze.render Template.loginButtons, document.getElementById 'loginContainer'

  #componentWillUnmount: ->
  #  Blaze.remove @view
  render: ->
    
    that = this
    reactKup (k) -> 
      k.build Span 
