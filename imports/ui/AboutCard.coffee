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
                  cols: 1
                  ->
                    N = {}
                    N.node = that.props.node
                    inLinks = that.props.node.in
                    outLinks = that.props.node.out
                    N.linksByTime = linkstate.sortByKeysTime(inLinks, that.props.howMany)
                    console.log N
                    for link in N.linksByTime
                      if inLinks[link]?
                        U = {}
                        U.usersConnections = inLinks[link]
                        # assume that first element has the correct title
                        U.currentTitle = U.usersConnections[Object.keys(U.usersConnections)[0]].meta.title
                        U.linksByTimeUsers = linkstate.sortByKeysTime(U.usersConnections)
                        U.origin = link
                        [U.firstUser, ... , U.lastUser] = U.linksByTimeUsers
                        [U.firstLink, ... , U.lastLink] = N.linksByTime
                        #console.log U, 'Users node'
                        k.build GridTile,
                          key: link+'Node'
                          title: U.currentTitle #m.body #target.title#FromLink
                          subtitle: U.firstUser
                          ->
                            counted = 0
                            for user in U.linksByTimeUsers
                              vote = U.usersConnections[user]
                              console.log vote#, U.usersConnections
                              size = style.scalars.screenshotWidth
                              if vote.meta?
                                k.img
                                  style: _.extend {},# style.webShot,
                                    top: counted *(size / 5)
                                    width: '10%' #style.scalars.screenshotWidth / 10
                                    left: 10 * vote.meta.weight + '%'
                                    position: 'absolute'
                                    opacity: 1
                                    borderRadius: '50%'
                                  src: vote.meta.face
                                counted++
                            k.span ''#U.currentTitle
                        n= 0
                        for key, node of that.props.node.in
                          #console.log key, node
                          if that.props.node.out? and that.props.node.out[key]
                            #console.log 'reciprical link', key # that.props.node.out[key],
                            n++
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
