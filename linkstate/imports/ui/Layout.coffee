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
exports.Layout = React.createClass
  getDefaultProps: ->
    expandMainCard: true
  render: ->
    that = this
    reactKup (k) ->
      if that.props.user?.out?.Bookmarks?[linkstate.store that.props.from]?.meta?.ScreenshotUrl?
        HERE = that.props.user.out.Bookmarks[ linkstate.store that.props.from]
        ScreenshotUrl = HERE.meta.ScreenshotUrl
      if HERE?.title?
        titleHere = HERE.title
        host = URI.parse(that.props.from).host
        title = R.concat R.concat( host, ' / '), titleHere
      else
        title = that.props.from
      k.build MuiThemeProvider,
        muiTheme: lightBaseUsTheme
        ->
          k.div ->
            #className: 'onlyOne'
            #->
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
                window.open that.props.from, "_blank"
            k.span 'g',-> # because... just because
            k.div
              style:
                marginTop: 150
              #className: 'main'
              ->
                if that.props.user?.services?.facebook?
                  k.build MainCard, # need comma here because the second arg is prop
                    expanded: that.props.expandMainCard
                    # redundant container? already have user obj here
                    to: that.props.to
                    from: that.props.from
                    word: that.props.word
                    content: that.props.content
                    user: that.props.user
                    lastTitle: that.props.lastTitle
                  k.build MyCard,
                    expanded: that.props.expandMyCard
                    to: that.props.to
                    lastTitle: that.props.lastTitle
                    from: that.props.from
                    word: that.props.word
                    user: that.props.user
                    incomming: that.props.incomming
                    howMany: 10
                    type: 'fromCreated'
                else
                  k.build Mexplain
                k.build AboutCard,
                  expanded: that.props.expandAboutCard
                  to: that.props.to
                  from: that.props.from
                  word: that.props.word
                  thumbalizr: that.props.thumbalizr
                  howMany: 15
                  user: that.props.user
            k.div ->
              k.build AccountsUIWrapper
