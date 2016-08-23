# MyCard.coffee shows my connections TO the place you are at
# because if you go TO bookmarks, you will see your bookmarks
# this is because bookmarks are links to bookmarks
# Bookmarks are here steps, auto generated when you newtab from a page.
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
    expanded: true
  render: ->
    console.log @props , 'work on props'
    that = this
    if @props.expanded is 'undefined'
      that.props.expanded = true
    reactKup (k) ->
      k.build Card,
        expanded: that.props.expanded
        style: _.extend {}, style.card, style.mCard
        ->
          k.build CardHeader,
            title: that.props.word.MyCardTitle + that.props.from
            subtitle: that.props.word.MyCardSubtitle
            showExpandableButton: true
            onClick: (e) ->
              changeQueryParams 'expandMyCard', !that.props.expanded
          k.build CardText,
            style:
              height: 'auto'
            expandable: true
            ->
              k.build GridList,
                #cellHeight: 200
                cols: 1
                ->
                  console.log that.props?.user?.out?[linkstate.store that.props.from]?
                  if that.props?.user?.out?[linkstate.store that.props.from]?
                    console.log that.props.user.out[linkstate.store that.props.from]
                    #out = that.props.user.out.Bookmarks # is collection of edges..
                    out = that.props.user.out[linkstate.store that.props.from]
                    n = 0
                    for mark in linkstate.sortByKeysTime(out, that.props.howMany)
                      target = out[mark]
                      m = target.meta
                      n++
                      if n <= that.props.howMany
                        k.build GridTile,
                          key: mark
                          title: m.body #target.title#FromLink
                          subtitle: m.FromLink#' => '+ m.ToLink
                          ->
                            k.img
                              style: _.extend {},# style.webShot,
                                left: 10 * m.weight + '%'
                                position: 'absolute'
                                opacity: 1
                              src: "http://graph.facebook.com/v2.7/" + that.props.user.services.facebook.id + "/picture?type=square"
                            k.img
                              style: _.extend {}, style.webShot,
                                width: '100%'
                              src:  "https://api.thumbalizr.com/?url="+m.FromLink+"&width=250&api_key=5VmUR42gc4eGdLjBnZH2BRXa"
###
# TODO

{@div, @span, @input, @img, @button} = React.DOM
@cond = (a,b,c) -> if a then b() else c?()
@createView = (spec) ->
  React.createFactory(React.createClass(spec))
#@Transition = React.createFactory(React.addons.CSSTransitionGroup)
div
  key: 'view'
  className: 'event view'
  span {},'here now'
  img
    className: 'cover'
  div
    className: 'title row pointer'
###
