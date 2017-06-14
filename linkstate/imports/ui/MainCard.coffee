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
IconButton = require('material-ui/lib/icon-button').default
Flip =  require('material-ui/lib/svg-icons/communication/swap-calls').default
ExitToPage =  require('material-ui/lib/svg-icons/action/exit-to-app').default
Print =  require('material-ui/lib/svg-icons/action/print').default
Edit =  require('material-ui/lib/svg-icons/editor/mode-edit').default

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
    #setInterval(focusTextbox,650)
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
            ->
              k.build IconButton,
                tooltip: "Reverse - Point TO what you're now pointing FROM"
                tooltipPosition: 'bottom-right'
                ref: 'blurer'
                onFocus: () ->
                  window.textAbout.refs.MainCardTextInput.focus()
                onClick: () ->
                  console.log FlowRouter.getQueryParam 'from', that.props.to
                  changeQueryParamsObject
                    from: that.props.to
                  changeQueryParamsObject
                    to: that.props.from
                ->
                  k.build Flip
              k.build IconButton,
                tooltip: "Visit the page you're connecting TO"
                tooltipPosition: 'bottom-right'
                onClick: () ->
                  window.open that.props.to
                ->
                  k.build ExitToPage
              k.build IconButton,
                tooltip: "Rich editing and markup of the page. Quote it for your notes. Screenshot a part perhaps?"
                tooltipPosition: 'bottom-right'
                style:
                  opacity: .4
                onClick: () ->
                  window.open that.props.to
                ->
                  k.build Edit
              k.build IconButton,
                #style:
                #  height: 0
                tooltip: "Archive the whole page for me. Request this or other features if you need it."
                tooltipPosition: 'bottom-right'
                ref: 'blurer4'
                style:
                  opacity: .4
                onFocus: () ->
                  window.textAbout.refs.MainCardTextInput.focus()
                onClick: () ->
                  window.open that.props.to
                ->
                  k.build Print
