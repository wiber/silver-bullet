#reactKup = require('react-kup')
React = require('react')
# ReactDOM = require('react-dom')
# {NavBar} = require './navBar.coffee'
{MainCard} = require './MainCard.coffee'
# {MyCard} = require './MyCard.coffee'
{AboutCard} = require './AboutCard.coffee'
{style} = require '../ui/style.coffee'
# CardActions = require 'material-ui/lib/card/card-actions'
# CardHeader = require 'material-ui/lib/card/card-header'
# FlatButton = require 'material-ui/lib/flat-button'
# CardText = require 'material-ui/lib/card/card-text'
AppBar =  require('@material-ui/core/AppBar').default
{Footer} = require('./Footer.jsx')
{Login} = require('./Login')
{DQ} = require('./Disqus')
{Disqus,DisqusConfig,LoadDisqus} = DQ
# Card = require 'material-ui/lib/card/card'
{AccountsUIWrapper} = require '../ui/AccountsUIWrapper.coffee'
{Mexplain} = require '../api/MexplainContainer.coffee'
URI = require 'uri-js'
# MuiThemeProvider = require('material-ui/lib/MuiThemeProvider.js').default
# {lightBaseUsTheme, letsMeSeeTheme} = require('../ui/theme.coffee')
Urlbox = require 'urlbox'
Lo = require 'lodash'
{see, store, linkstate} = require '../api/strings'
{screenshotUrlHere, hereAndThere} = require '../api/ModelOperations'
{div, a,} = React.DOM

exports.Layout = React.createClass
  componentDidUpdate: ->
    DQ.DisqusConfig(@props.from)
  render: ->
    that = this
    try
      if that?.props?.user?.links?.in?.Bookmarks?[linkstate.store that.props.from]?.meta?.ScreenshotUrl?
        HERE = that.props.user.links.in.Bookmarks[ linkstate.store that.props.from]
        ScreenshotUrl = HERE.meta.ScreenshotUrl
      # old way still here..
      urlbox = Urlbox(Meteor.settings.public.urlbox.key, Meteor.settings.public.urlbox.secret)
      before = ScreenshotUrl
      ScreenshotUrl = urlbox.buildUrl
        url: that.props.from
        thumb_width: 320
        format: 'png'
        quality: 80
      if before is ScreenshotUrl
        console.log 'ScreenshotUrl was same'
    catch error
        console.error error, 'good try urlbox'
    if HERE?.title?
      titleHere = HERE.title
      host = URI.parse(that.props.from).host
      if host?
        slash = R.concat host, ' / '
      else
        slash = R.concat that.props.from, ' / '
      title = R.concat slash, titleHere
    else
      title = that.props.from
    div
      className: 'row'
      div
        style: _.extend {}, style.base,
          height: '100%'
          widht: '100%'
          position: 'fixed'
          backgroundImage: 'url(' + ScreenshotUrl + ')'
          backgroundRepeat: 'no-repeat'
          backgroundSize: '100% 110%'
          opacity: '.3'
          zIndex: -1
      div
        style:
          marginTop: 150
        className: 'column'
        div

          if that.props.user?.services?
            React.createElement MainCard,
              "to": that.props.to
              "from": that.props.from
              "word": that.props.word
              "content": that.props.content
              "user": that.props.user
              "lastTitle": that.props.lastTitle
              "newHere": that.props.newHere
          React.createElement AboutCard,
              "expanded": that.props.expandAboutCard
              "to": that.props.to
              "from": that.props.from
              "word": that.props.word
              "thumbalizr": that.props.thumbalizr
              "howMany": 15
              "user": that.props.user
          div
            React.createElement Login,
              props: @props
              user: @props.user

      div
        className: 'columnR'
        style:
          marginTop: "150px"
        div
          style:
            class: "column"
          unless window.disqusLoadedFalse
            console.log @props.from
            React.createElement DQ.LoadDisqusButton,
              from: that.props.from
              onClick: (event) ->
                console.log event, DQ, that.props.from
                DQ.DisqusConfig that.props.from
                return React.createElement DQ.Disqus,
                  from: that.props.from
          #else
          React.createElement DQ.Disqus,
            from: that.props.from
