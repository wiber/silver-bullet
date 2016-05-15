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
Card = require 'material-ui/lib/card/card'


MuiThemeProvider = require('material-ui/lib/MuiThemeProvider.js').default
{lightBaseUsTheme} = require('../ui/theme.coffee')
exports.Layout = React.createClass
  getDefaultProps: ->
    expandMainCard: true
  componentDidMount: ->
  render: ->
    that = this
    reactKup (k) ->
      k.build MuiThemeProvider,
        muiTheme: lightBaseUsTheme
        ->
          k.div
            className: 'onlyOne'
            style: _.extend {}, style.base,
              margin: 0
              padding: 0
            ->
              k.div 'header'
              k.div
                className: 'main'
                ->
                  k.build MainCard, # need comma here because the second arg is prop
                    expanded: that.props.expandMainCard
                    to: that.props.to
                    from: that.props.from
                    word: that.props.word
                  k.build MyCard,
                    expanded: that.props.expandMyCard
                    to: that.props.to
                    from: that.props.from
                    word: that.props.word
                  k.build AboutCard,
                    expanded: that.props.expandAboutCard
                    to: that.props.to
                    from: that.props.from
                    word: that.props.word

              k.div 'footer'
