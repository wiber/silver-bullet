# MyCard.coffee shows my incomming connections TO the place you are at
# because if you go TO bookmarks, you will see your bookmarks
# this is because bookmarks are links to bookmarks
# Bookmarks are here steps, auto generated when you newtab from a page.
reactKup = require('react-kup')
{createContainer} = require 'meteor/react-meteor-data'

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

MyCard = React.createClass
  getDefaultProps: ->
    expanded: true
  render: ->
   #console.log @props , 'work on props'
    that = this
    if @props.expanded is 'undefined'
      that.props.expanded = true
    reactKup (k) ->
      k.build Card,
        expanded: that.props.expanded
        style: _.extend {}, style.card, style.yCard
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
                  console.log that.props.user
                  from = linkstate.store that.props.from
                  user = that.props.user
                  if user?.out?[from]? or user?.in?[from]?
                    out = that.props.user.out[linkstate.store that.props.from]
                    console.log that.props.user.in
                    console.log that.props.user.in[linkstate.store that.props.from]
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
                              src: m.face
                            k.img
                              style: _.extend {}, style.webShot,
                                width: '100%'
                              src: m.ScreenshotUrl
                              from: m.FromLink
                              onClick: (e) ->
                               changeQueryParams 'from', e.target.getAttribute('from')
exports.MyCard = createContainer ((props) ->
  newProps = {}
  if props.from?
    Meteor.subscribe "userData"
    user = Meteor.user()

  if user?
    newProps.user = user
  console.log newProps.user == props.user
  props = _.extend {}, props, newProps
  console.log newProps.user == props.user
  props
), MyCard
