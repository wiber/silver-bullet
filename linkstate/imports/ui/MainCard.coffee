reactKup = require('react-kup')
React = require('react')
{style} = require('../ui/style.coffee')
{changeQueryParams, changeQueryParamsObject} = require('../api/changeQueryParams.coffee')
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
  componentDidMount: ->
    focusTextbox = () ->
      select = document.activeElement.type is 'text'
      text = document.activeElement.id is 'textAbout'
      unless select or text
        if false is true and window?.textAbout?.refs?.MainCardTextInput?.focus()
          window.textAbout.refs.MainCardTextInput.focus()
          #$('#textAbout').focus()
        console.log document.activeElement.id, document.activeElement.type
    setInterval(focusTextbox,650)
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
            onClick: (e) ->
              window.open HERE.meta.FromLink
          k.build CardMedia,
            style: style.overlayPercentage
            onClick: (e) ->
              win = window.open(decodeURIComponent HERE.from, '_blank')
              win.focus()
          k.build CardText,
            ->
              k.build FromToSense,
                from: that.props.from
                to: that.props.to
                lastTitle: that.props.lastTitle
                word: that.props.word
                content: that.props.content
                user: that.props.user
          k.build CardActions,
            -> # return innerhtml, tags on here before
              k.build FlatButton,
                #style:
                #  height: 0
                label: 'Switch'
                refs: 'blurer'
                onFocus: () ->
                  window.textAbout.refs.MainCardTextInput.focus()
                onClick: () ->
                  console.log FlowRouter.getQueryParam 'from', that.props.to
                  changeQueryParamsObject
                    from: that.props.to
                  changeQueryParamsObject
                    to: that.props.from
              if that.props.user.in[linkstate.store that.props.from]?
                console.log that.props.user.in[linkstate.store that.props.from]
                k.build FlatButton,
                  #style:
                  #  height: 0
                  label: 'old Text'
                  refs: 'blurer'
                  onFocus: () ->
                    window.textAbout.refs.MainCardTextInput.focus()
                  onClick: () ->
                    console.log FlowRouter.getQueryParam 'from', that.props.to
                    changeQueryParamsObject
                      from: that.props.to
                    changeQueryParamsObject
                      to: that.props.from
