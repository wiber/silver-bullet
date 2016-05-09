reactKup = require('react-kup')
React = require('react')

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
      k.build Card,
        expanded: that.props.expanded
        style:
          height: 'auto'
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
          k.build CardText,
            expandable: true
            ->
              k.span that.props.from, ' '
              k.span that.props.to
          k.build CardActions,
            -> # return innerhtml, tags on here before
              k.build FlatButton,
                style:
                  height: 0
                label: 'Tab here to go back to "From"'
                onFocus: () ->
                  # TODO avoid global here..
                  window.from.refs.from.focus()
