# renders the aboutness node from here
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
{GridList, GridTile} = require 'material-ui/lib/grid-list'
{Subheader} = require 'material-ui/lib/Subheader'
{StarBorder} = require 'material-ui/lib/svg-icons/toggle/star-border'

{createContainer} = require 'meteor/react-meteor-data'
{see, store} = require '../api/strings.coffee'
AboutCard = React.createClass
  handleToggle: (e) ->
    changeQueryParams 'expandAboutCard', !@props.expanded
  render: ->
    that = this
    reactKup (k) ->
      k.build Card,
        expanded: that.props.expanded
        style: _.extend {}, style.card, style.mAcard
        ->
          k.build CardHeader,
            title: that.props.word.AboutCardTitle
            showExpandableButton: true
            subtitle: that.props.word.AboutCardSubTitle
            onClick: that.handleToggle
          k.build CardText,
            style:
              height: 'auto'
          k.build CardText,
            expandable: true
            ->
              # cycle through in links... render them and related out links
              # we are interested in what people are linking 'sending' to this place
              # can we make it less abstract? is the bidirectional association necessary?
              # how much power do we gain by weight, and direct
              if that.props.node?.in?
                k.build GridList,
                  class: 'looplist'
                  ->
                    H = linkstate.store that.props.from
                    N = {}
                    N.node = that.props.node
                    N.inLinks = that.props.node.in
                    N.outLinks = that.props.node.out
                    N.outFromHere = N.outLinks[H]
                    N.inToHere = N.inLinks[H]
                    # incoming links are important as they define this place
                    N.links = _.extend {}, N.outFromHe, N.inToHere
                    N.deChaos = linkstate.sortByKeysTime(N.links, that.props.howMany)
                    console.log N
                    # to keep things unique.. it's from.user.to
                    # we need to make from.to.user.node. to make sense of what is said about each
                    # this can be done in methods..
                    # or we can make another field... which has directionality in meta
                    # which questions? what's said about this assoc
                    # vs what is my connections from here..
                    for mark in N.deChaos
                      if N.inLinks[mark]?
                        N.usersConnections = N.inLinks[mark]
                        # assume that first element has the correct title
                        N.currentTitle = N.usersConnections[Object.keys(N.usersConnections)[0]].meta.title
                        N.deChaosUsers = linkstate.sortByKeysTime(N.usersConnections)

                        N.origin = mark
                        [N.firstUser, ... , N.lastUser] = N.deChaosUsers
                        [N.firstLink, ... , N.lastLink] = N.deChaos
                        console.log N, 'N node'
                        if N.outLinks[mark]?
                          backLink = N.outLinks[mark]
                          console.log 'reciprical link', mark, N.outLinks[mark]
                        k.build GridTile,
                          key: mark+'Node'
                          title: N.currentTitle #m.body #target.title#FromLink
                          subtitle: N.firstUser
                          ->
                            k.span N.currentTitle
              k.span that.props.from, ' '
              k.span that.props.to
          k.build CardActions,
            expandable: false
            -> # return innerhtml, tags on here before
              k.build FlatButton,
                style:
                  height: 0
                label: 'Tab here to go back to "From"'
                onFocus: () ->
                  # TODO avoid global here..
                  window.from.refs.from.focus()

exports.AboutCard = createContainer ((props) ->
  newProps = {}
  if props.from?
    Meteor.subscribe "Node", props.from
  N = Nodes.findOne(linkstate.store props.from)
  if N?
    newProps.node = N
  console.log newProps.node, Nodes.find({}).count()
  props = _.extend {}, props, newProps
  props
), AboutCard
