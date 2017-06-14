# MyCard.coffee shows my incomming connections TO the place you are at
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
Toggle = require('material-ui/lib/toggle').default
{Mexplain} = require '../api/MexplainContainer.coffee'
{selectedContainer} = require '../api/Selected.coffee'
Print =  require('material-ui/lib/svg-icons/action/print').default
IconButton = require('material-ui/lib/icon-button').default
Paper = require('material-ui/lib/paper').default
Avatar = require('material-ui/lib/avatar').default

exports.MyCard = React.createClass
  getDefaultProps: ->
    expanded: true
  render: ->
    that = this
    if @props.expanded is 'undefined'
      that.props.expanded = true
    reactKup (k) ->
      k.build Card,
        expanded: that.props.expanded
        style: _.extend {}, style.card, style.yCard
        ->
          ###k.build CardHeader,
            title: that.props.word.MyCardTitle# + that.props.from
            #subtitle: that.props.word.MyCardSubtitle
            showExpandableButton: true
            onClick: (e) ->
              changeQueryParams 'expandMyCard', !that.props.expanded###
          k.build CardText,
            style:
              height: 'auto'
              minHeight: 500
              overflow: 'hidden'
            expandable: false
            ->
              k.build selectedContainer,
                from: that.props.from
                to: that.props.to
                lastTitle: that.props.lastTitle
                user: that.props.user
                type: 'from'
                word: that.props.word
                lastTitle: that.props.lastTitle
              k.build Paper,
                circle: true
                style:
                  width: 400
                  height: 400
                  marginRight: -200
                  marginTop: 150
                  marginBottom: 150
                  float: 'right'
                  display: 'inline'
                zDepth: 5
                overflow: 'hiddens'
                #children:
                ->
                  k.build Avatar,
                    style:
                      width: 400
                      height: 400
                      marginRight: 0
                      marginTop: 0
                      marginBottom: 0
                      float: 'right'
                      display: 'inline'
                    size: 200
                    src: that.props.ScreenshotUrl
          k.build CardText,
            style:
              height: 'auto'
            expandable: false
            ->
              k.build GridList,
                #cellHeight: 200
                cols: 1
                ->
                  if that.props?.user?.out?[linkstate.store that.props.from]?
                    out = that.props.user.out[linkstate.store that.props.from]
                    n = 0
                    for mark in linkstate.sortByWeight(out, that.props.howMany)
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
                                borderRadius: '50%'
                              src: m.face
                            k.img
                              style: _.extend {}, style.webShot,
                                width: '100%'
                              src: m.ScreenshotUrl
                              from: m.FromLink
                              onClick: (e) ->
                                changeQueryParams 'from'
                                , e.target.getAttribute('from')
