{style} = require '../ui/style.coffee'
reactKup = require('react-kup')
SimpleSelect = require("react-selectize").SimpleSelect
React = require 'react'
{changeQueryParams} = require('../api/changeQueryParams.coffee')
{see, store} = require '../api/strings.coffee'

exports.bulletUnit = React.createClass
  render: ->
    that = this
    reactKup (k) ->
      k.div
        style: {}
      ->
        k.a
          href: that.props.from
          target: '_blank'
          style:
            borderRadius: '0 50% 50% 0'
            width: '100%'
          k.img
            src: that.props.srcFrom
        k.a
          href: that.props.to
          style:
            position: 'absolute'
            width: '100%'
          target: '_blank'
          k.img
            src: that.props.srcFrom
