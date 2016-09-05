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
                  console.log that.props, 'props'
                  from = linkstate.store that.props.from
                  user = that.props.user
                  if user?.out?[from]? or user?.in?[from]?
                    # either can be undefined...
                    outLinks = user.out[from]
                    inLinks = user.in[from]
                    links = _.extend {}, inLinks, outLinks
                    console.log 'outLinks, inLinks, links',outLinks, inLinks, links
                    linkArray = linkstate.sortByKeysTime(links, that.props.howMany)
                    console.log 'linkArray.length',linkArray.length
                    n = 0
                    outCount = 0
                    for mark in linkArray
                      if outLinks?[mark]?
                        target = outLinks[mark]
                        m = target.meta
                        n++
                        if n <= that.props.howMany
                          k.build bookLink,
                            target: target
                            m: m
                            mark: mark
                      else # it's an incoming link.. do the first only..
                        if outCount is 0 and inLinks?[mark]?
                          outCount++
                          target = inLinks[mark]
                          m = target.meta
                          k.build bookLink,
                            target: target
                            m: m
                            mark: mark


bookLink = React.createClass
  render: ->
    that = this
    reactKup (k) ->
      k.build GridTile,
        key: that.props.mark
        title: that.props.m.body + ' ' + that.props.m.ToLink #target.title#FromLink
        subtitle: that.props.m.FromLink #' => '+ m.ToLink
        ->
          k.img
            style: _.extend {},# style.webShot,
              left: 10 * that.props.m.weight + '%'
              position: 'absolute'
              opacity: 1
            src: that.props.m.face
          k.img
            style: _.extend {}, style.webShot,
              width: '100%'
            src: that.props.m.ScreenshotUrl
            from: that.props.m.FromLink
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
