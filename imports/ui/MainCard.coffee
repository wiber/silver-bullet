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
    expanded: false
  handleToggle: (e) ->
    changeQueryParams 'expandMainCard', !@props.expanded
  render: ->
    that = this
    reactKup (k) ->
      k.build Card, # build the Card component
        expanded: that.props.expanded # add argument key value pairs
        style: _.extend {}, style.card,
          background: 'rgba(150, 25, 25, .05)'
        ->
          k.build CardHeader,
            title: that.props.word.MainCardTitle
            subtitle: that.props.word.MainCardSubtitle
            showExpandableButton: true
            onClick: that.handleToggle
          k.build CardText,
            style:
              height: 'auto'
            -> k.build FromToSense,
              from: that.props.from
              to: that.props.to
              word: that.props.word
          k.build CardText,
            expandable: true
            ->
              console.log style.h1
              k.h1
                style: style.h1
                'this card is about '
              k.span that.props.from, ' '
              k.h2
                style: style.h2
                ' and your connections from it such as '
              k.span that.props.to
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
