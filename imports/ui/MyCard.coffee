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
{GridList, GridTile} = require 'material-ui/lib/grid-list'
{Subheader} = require 'material-ui/lib/Subheader'
{StarBorder} = require 'material-ui/lib/svg-icons/toggle/star-border'

exports.MyCard = React.createClass
  getDefaultProps: ->
    expanded: false
  handleToggle: (e) ->
    changeQueryParams 'expandMyCard', !@props.expanded
  render: ->
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
              k.build GridList,
                #cellHeight: 200
                cols: 1
                Subheader: that.props.word.MyCardStepsSubheader
                ->
                  if that.props?.user?.out?
                    out = that.props.user.fromCreated # is collection of edges..
                    n = 0
                    for mark in linkstate.sortByKeysTime out, 11
                      target = out[mark]
                      m = target.meta
                      n++
                      if n <= 10
                        k.build GridTile,
                          key: mark
                          title: m.FromLink
                          subtitle: '=> '+ m.ToLink
