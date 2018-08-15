reactKup = require('react-kup')
React = require('react')
ReactDOM = require('react-dom')
{MainCard} = require './MainCard.coffee'
{MyCard} = require './MyCard.coffee'
{AboutCard} = require './AboutCard.coffee'
{style} = require '../ui/style.coffee'
CardActions = require 'material-ui/lib/card/card-actions'
CardHeader = require 'material-ui/lib/card/card-header'
FlatButton = require 'material-ui/lib/flat-button'
CardText = require 'material-ui/lib/card/card-text'
AppBar =  require('material-ui/lib/app-bar').default
Card = require 'material-ui/lib/card/card'
{AccountsUIWrapper} = require '../ui/AccountsUIWrapper.coffee'
{Mexplain} = require '../api/MexplainContainer.coffee'
URI = require 'uri-js'
MuiThemeProvider = require('material-ui/lib/MuiThemeProvider.js').default
{lightBaseUsTheme} = require('../ui/theme.coffee')
`import Urlbox from 'urlbox';`
Lo = require 'lodash'
{see, store, linkstate} = require '../api/strings'
{screenshotUrlHere} = require '../api/ModelOperations'

exports.Layout = React.createClass
  getDefaultProps: ->
    expandMainCard: true
  componentDidMount: ->


  render: ->
    window.fbAsyncInit = ->
      FB.init
        appId: that.props.facebookAppId
        autoLogAppEvents: true
        xfbml: true
        version: 'v2.11'
      return
    if document?
      ((d, s, id) ->
        js = undefined
        fjs = d.getElementsByTagName(s)[0]
        if d.getElementById(id)
          return
        js = d.createElement(s)
        js.id = id
        js.src = 'https://connect.facebook.net/en_US/sdk.js'
        fjs.parentNode.insertBefore js, fjs
        return
      ) document, 'script', 'facebook-jssdk'
    that = this
    console.log screenshotUrlHere that.props.user, that.props.from
    reactKup (k) ->
      #console.log that.props.user.services, Meteor.user().services

      try
        if that?.props?.user?.links?.in?.Bookmarks?[linkstate.store that.props.from]?.meta?.ScreenshotUrl?
          HERE = that.props.user.links.in.Bookmarks[ linkstate.store that.props.from]
          ScreenshotUrl = HERE.meta.ScreenshotUrl
        # old way still here..
        urlbox = Urlbox(Meteor.settings.public.urlboxKey, Meteor.settings.urlboxSecret)
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
      k.build MuiThemeProvider,
        muiTheme: lightBaseUsTheme
        ->
          k.div ->
            className: 'row'
            k.div
              style: _.extend {}, style.base,
                height: '100%'
                widht: '100%'
                position: 'fixed'
                backgroundImage: 'url(' + ScreenshotUrl + ')'
                backgroundRepeat: 'no-repeat'
                backgroundSize: '100% 110%'#'cover' #'100% auto'
                opacity: '.3'
                zIndex: -1
            k.build AppBar,
              title: that.props.word.HeaderTitle + title # that.props.from
              iconElementLeft: k.span ''
              style:
                position: 'fixed'
              onClick: () ->
                window.open 'http://' + that.props.from, "_blank"
            k.span 'g',-> # because... just because otherwise appbar bugs out
            k.div
              style:
                marginTop: 150
              className: 'column'
              ->
                k.div ->
                  if that.props.user?.services?.facebook? or that.props.user?.services?.password?
                    k.build MainCard, # need comma here because the second arg is prop
                      expanded: that.props.expandMainCard
                      # redundant container? already have user obj here
                      to: that.props.to
                      from: that.props.from
                      word: that.props.word
                      content: that.props.content
                      user: that.props.user
                      lastTitle: that.props.lastTitle
                      newHere: that.props.newHere
                    k.build MyCard,
                      styles: style
                      expanded: that.props.expandMyCard
                      to: that.props.to
                      lastTitle: that.props.lastTitle
                      from: that.props.from
                      word: that.props.word
                      user: that.props.user
                      incomming: that.props.incomming
                      howMany: 10
                      type: 'fromCreated'
                      ScreenshotUrl: ScreenshotUrl
                  else
                    k.build Mexplain,
                      word: that.props.word
                  k.build AboutCard,
                    expanded: that.props.expandAboutCard
                    to: that.props.to
                    from: that.props.from
                    word: that.props.word
                    thumbalizr: that.props.thumbalizr
                    howMany: 15
                    user: that.props.user

            k.div
              className: 'columnR'
              style:
                marginTop: 150# '15%'
              ->
                k.div
                  id: 'fb-root'
                k.div
                  style:
                    marginTop: '15%'
                  className:"fb-comments"
                  dataHref:"http://linkstate.youiest.com/about?from="+encodeURIComponent(that.props.from)
                  dataNumposts: "5"
                k.div ->
                  k.build AccountsUIWrapper
