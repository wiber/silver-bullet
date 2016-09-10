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
                    N = {}
                    N.node = that.props.node
                    inLinks = that.props.node.in
                    outLinks = that.props.node.out
                    N.deChaos = linkstate.sortByKeysTime(that.props.node.in, that.props.howMany)
                    for mark in N.deChaos
                      if inLinks[mark]?
                        N.usersConnections = inLinks[mark]
                        # assume that first element has the correct title
                        N.currentTitle = N.usersConnections[Object.keys(N.usersConnections)[0]].meta.title
                        N.deChaosUsers = linkstate.sortByKeysTime(N.usersConnections)

                        N.origin = mark
                        [N.firstUser, ... , N.lastUser] = N.deChaosUsers
                        [N.firstLink, ... , N.lastLink] = N.deChaos
                        #console.log N, 'N node'
                        k.build GridTile,
                          key: mark+'Node'
                          title: N.currentTitle #m.body #target.title#FromLink
                          subtitle: N.firstUser
                          ->
                            k.span N.currentTitle
                        for key, node of that.props.node.in
                          #console.log key, node
                          if that.props.node.out? and that.props.node.out[key]
                            console.log 'reciprical link', key # that.props.node.out[key], 
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
  #console.log newProps.node, Nodes.find({}).count()
  props = _.extend {}, props, newProps
  props
), AboutCard
