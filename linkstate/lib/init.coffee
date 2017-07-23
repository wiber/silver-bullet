@React = require 'react'
@R = require('ramda')
{@div, @span, @input, @img, @button} = React.DOM
#@Transition = React.createFactory(React.addons.CSSTransitionGroup)
@cond = (a,b,c) -> if a then b() else c?()
@createView = (spec) ->
  React.createFactory(React.createClass(spec))
@thumbalizrPic = (url) ->
  console.log url, Meteor.settings.public.thumbalizr
