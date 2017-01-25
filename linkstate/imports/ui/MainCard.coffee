reactKup = require('react-kup')
React = require('react')
{style} = require('../ui/style.coffee')
{changeQueryParams} = require('../api/changeQueryParams.coffee')
{FromToSense} = require('../ui/FromToSense.coffee')
Card = require('material-ui/lib/card/card').default
CardActions = require('material-ui/lib/card/card-actions' ).default
CardHeader = require('material-ui/lib/card/card-header').default
CardMedia = require('material-ui/lib/card/card-media').default
CardTitle = require('material-ui/lib/card/card-title').default
FlatButton = require('material-ui/lib/flat-button' ).default
CardText =  require('material-ui/lib/card/card-text').default

exports.MainCard = React.createClass
  getDefaultProps: ->
    expanded: true
  render: ->
    that = this
    if that?.props?.user?.out?.Bookmarks?[ linkstate.store that.props.from]?
      HERE = that.props.user.out.Bookmarks[ linkstate.store that.props.from]
      ScreenshotUrl = HERE.meta.ScreenshotUrl
    else HERE = {}
    reactKup (k) ->
      k.build Card, # build the Card component
        expanded: that.props.expanded # add argument key value pairs
        style: _.extend {}, style.card, style.mCard
        ->
          k.build CardHeader,
            title: HERE.title,
            subtitle: that.props.word.MainCardSubtitle
            showExpandableButton: false
            onClick: (e) -> #that.handleToggle
              window.open HERE.meta.FromLink
              #changeQueryParams 'expandMainCard', !that.props.expanded
          k.build CardMedia,
            style: style.overlayPercentage
            onClick: (e) ->
              win = window.open(decodeURIComponent HERE.from, '_blank');
              win.focus();
            ###->
              k.img
                src: ScreenshotUrl###
          k.build CardText,
            ->
              k.build FromToSense,
                from: that.props.from
                to: that.props.to
                word: that.props.word
                content: that.props.content
                user: that.props.user
          k.build CardActions,
            -> # return innerhtml, tags on here before
              k.build FlatButton,
                style:
                  height: 0
                label: 'Tab here to go back to "From"'
                onFocus: () ->
                  # TODO avoid global here..
                  # react element has a ref to the dom element
                  window.textAbout.refs.MainCardTextInput.focus()
