{style} = require '../ui/style.coffee'
reactKup = require('react-kup')
SimpleSelect = require("react-selectize").SimpleSelect
React = require 'react'
{changeQueryParams} = require('../api/ModelOperations.coffee')
{see, store} = require '../api/strings.coffee'


bulletUnitDiv = React.createClass
 render: ->
    div
      className: 'dummy'
      style: {}
      a
        href: props?.from
        target: '_blank'
        style:
          borderRadius: '0 50% 50% 0'
          width: '100%'
        k.img
          src: props?.srcFrom
      a
        href: props?.to
        style:
          position: 'absolute'
          width: '100%'
        target: '_blank'
        k.img
          src: props?.srcFrom

exports.bulletUnit = React.createClass
  render: ->
    that = this
    reactKup (k) ->
      k.build bulletUnitDiv