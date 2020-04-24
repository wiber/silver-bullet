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
{Disqus} = require('./Disqus')
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
# CookieConsent = require "react-cookie-consent"
#{CookieConsent} = require "react-cookie-consent"
# console.log("Nicolson here..")
# console.log(CookieConsent)

{div, a,} = React.DOM

exports.Layout = React.createClass
  #getDefaultProps: ->
  #  expandMainCard: true
  componentDidUpdate: ->
    disqus_config = ->
      @page.url = window.location
      # Replace PAGE_URL with your page's canonical URL variable
      @page.identifier = linkstate.store @props.from
      # Replace PAGE_IDENTIFIER with your page's unique identifier variable
      return
    unless window.disqusLoaded
      do ->
        # DON'T EDIT BELOW THIS LINE
        d = document
        s = d.createElement('script')
        s.src = 'https://decivote.disqus.com/embed.js'
        s.setAttribute 'data-timestamp', +new Date
        (d.head or d.body).appendChild s
        window.disqusLoaded = true
        return
    return
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
      #else
      #  console.log '!!!!!!!!!!!ScreenshotUrl', before, ScreenshotUrl
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
          backgroundSize: '100% 110%'#'cover' #'100% auto'
          opacity: '.3'
          zIndex: -1
      # React.createElement AppBar, {"title": that.props.word.HeaderTitle, "style": {"position": 'fixed'}} #this is header
      div
        style:
          marginTop: 150
        className: 'column'
        div

          if that.props.user?.services?#.facebook? or that.props.user?.services?.password?
            #console.log {that}
            React.createElement MainCard,
              #{}"expanded": that.props.expandMainCard
              "to": that.props.to
              "from": that.props.from
              "word": that.props.word
              "content": that.props.content
              "user": that.props.user
              "lastTitle": that.props.lastTitle
              "newHere": that.props.newHere
          #else
          #  React.createElement Mexplain,
          #    "word": that.props.word
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
        style:# _.extend {}, style.base,
          marginTop: "150px"# '15%'"
        # a
        #   href: "https://drive.google.com/open?id=0BxESHlfBQRFGazlwYzVYaThRczA"
        #   target: "_blank"
        #   "To use this app properly you need the chrome extension. Download, extract it and chrome://extensions unpacked."
        # div
        #   React.createElement AccountsUIWrapper, {}

        #div
        #  id: 'fb-root'
        #   React.createElement CookieConsent, {}
        div
          style:
            class: "column"
          # FIXME rerenders too often
          React.createElement Disqus,
            #from: that.props.from
            #url: that.props.url
            # we only rerender when from changes
            from: that.props.from
