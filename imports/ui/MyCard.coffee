reactKup = require('react-kup')
React = require('react')
{style} = require('../ui/style.coffee')
{changeQueryParams} = require('../api/changeQueryParams.coffee')
Card = require('material-ui/lib/card/card').default
CardActions = require('material-ui/lib/card/card-actions' ).default
CardHeader = require('material-ui/lib/card/card-header').default
CardMedia = require('material-ui/lib/card/card-media').default
CardTitle = require('material-ui/lib/card/card-title').default
FlatButton = require('material-ui/lib/flat-button' ).default
CardText =  require('material-ui/lib/card/card-text').default



exports.MyCard = React.createClass
  getDefaultProps: ->
    expanded: false
  handleToggle: (e) ->
    changeQueryParams 'expandMyCard', !@props.expanded
  render: ->
    console.log @props.user
    that = this
    reactKup (k) ->
      k.build Card,
        expanded: that.props.expanded
        style: _.extend {}, style.card, style.mCard
        ->
          k.build CardHeader,
            title: that.props.word.MyCardTitle
            subtitle: that.props.word.MyCardSubtitle
            showExpandableButton: true
            onClick: that.handleToggle
          k.build CardText,
            style:
              height: 'auto'
            expandable: true
            ->
              k.span that.props.from, ' '
              k.span that.props.to
