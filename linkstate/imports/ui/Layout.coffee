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
        #console.log 'weeeee down the rabbit hole', ScreenshotUrl, HERE
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
            k.div ->
            k.build AppBar,
              title: that.props.word.HeaderTitle
              iconElementRight: -> k.build AccountsUIWrapper
            k.div
              style: {}
              #className: 'main'
              ->
                k.build Mexplain
                if that.props.user?.services?.facebook?
                  k.build MainCard, # need comma here because the second arg is prop
                    expanded: that.props.expandMainCard
                    # redundant container? already have user obj here
                    to: that.props.to
                    from: that.props.from
                    word: that.props.word
                    content: that.props.content
                    user: that.props.user
                  k.build MyCard,
                    expanded: that.props.expandMyCard
                    to: that.props.to
                    from: that.props.from
                    word: that.props.word
                    user: that.props.user
                    incomming: that.props.incomming
                    howMany: 10
                    type: 'fromCreated'
                k.build AboutCard,
                  expanded: that.props.expandAboutCard
                  to: that.props.to
                  from: that.props.from
                  word: that.props.word
                  thumbalizr: that.props.thumbalizr
                  howMany: 15
            k.div 'footer'
