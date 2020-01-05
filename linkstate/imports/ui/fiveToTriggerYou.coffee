React = require 'react'
IconButton = require('material-ui/lib/icon-button').default #@material-ui/core/IconButton not working
RaisedButton = require('material-ui/lib/raised-button').default
TextField = require('material-ui/lib/TextField').default
Avatar = require('material-ui/lib/avatar').default # @material-ui/core/Avatar not working
{changeQueryParams, changeQueryParamsObject} = require('../api/changeQueryParams.coffee')

{div, br, span,a,img} = React.DOM
R = require 'ramda'
{getFiveLatestBookmarks, getFiveTargets} = require '../api/ModelOperations'
_ = require 'lodash'
exports.fiveToTriggerYou = React.createClass
  render: ->
    counter = 0
    number = 5
    style =
      margin: 0
    if @props?.user?.services?#@state.isLoggedIn # @props?.props?.user
      div
        className: 'container'
        style:
          position: 'relative'
        div
          for N in getFiveTargets(@props.user,5)
            console.log N
            counter++
            ScreenshotUrl = _.get(N,'meta.ScreenshotUrlTo')
            #console.log N,ScreenshotUrl,counter
            React.createElement IconButton,
              tooltip: _.get N, 'meta.ToLink'
              tooltipStyles:
                top: -5
                position: "absolute"
              tooltipPosition: "top-right"
              touch: true
              to: N.to
              style:
                width: "20%"
                left: "-20%"
                zIndex: 5-counter
              onClick: (e) ->
                changeQueryParamsObject
                  to: @to
              React.createElement Avatar,
                size: 200
                src: ScreenshotUrl
                position: "relative"
                float: "left"
        # should be replaced by last active tabs from extensions
        # the array of you bouncing around between steps
        # take
        ###
        for N in getFiveLatestBookmarks(@props.user, number)
          counter++
          ScreenshotUrl = _.get(N,'meta.ScreenshotUrl')
          #console.log N,ScreenshotUrl,counter
          React.createElement IconButton,
            tooltip: _.get N, 'title'
            touch: true
            from: N.from
            style:
              width: "20%"
              left: "-20%"
            onClick: (e) ->
              changeQueryParamsObject
                to: @from
            React.createElement Avatar,
              size: 100
              src: ScreenshotUrl
              position: "relative"
              float: "left"
###
