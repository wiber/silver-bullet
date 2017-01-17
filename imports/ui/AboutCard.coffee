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
{bulletUnitContainer} = require '../../imports/api/bulletUnit.coffee'
{UrlBox} = require '../../imports/ui/UrlBox.coffee'

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
              # we need to assemble the data struc
              # what's needed for a card
              # url, title
              # and the votes that go on a link
              # face, profile, blurb, direction
              #
              # cycle through in links... render them and related out links
              # we are interested in what people are linking 'sending' to this place
              # can we make it less abstract? is the bidirectional association necessary?
              # how much power do we gain by weight, and direct
              if that.props.node?.in?
                k.build GridList,
                  class: 'looplist'
                  cols: 1
                  ->
                    # conditionals are ok, but we should move out data processing into pure functions with wallaby tests
                    # end result is a modular and clean way to render urls and votes
                    # from to header, list of comments with face votes..
                    # TODO reduce size of loops,
                    # for each url, paint header, paint each vote
                    # how much do we gain by pre forming object in this composer?
                    # can we rethink this as seeing one kind at a time from dropdown or will that break that aboutness feel we want?
                    #
                    N = {} # the node we're on
                    N.node = that.props.node

                    N.inLinks = that.props.node.in
                    N.outLinks = that.props.node.out
                    N.allLinks = _.extend {}, N.inLinks, N.outLinks

                    N.linksByTime = linkstate.sortByKeysTime(N.allLinks, that.props.howMany)
                    N.linkSort = {}
                    for link in Object.keys(N.allLinks)
                      N.sorts = linkstate.sortByKeysTime(N.allLinks[link],3)
                      N.recent = N.sorts[0]
                      N.linkSort[link] = N.allLinks[link][N.recent]
                    # calculate momentum of a url by walking through voters on it
                    N.momentum = {}
                    N.vectors = {}
                    for link in Object.keys N.allLinks
                      console.log link, N.allLinks[link], 'link keys', Object.keys N.allLinks[link]
                      for voter of N.allLinks[link]
                        console.log voter, 'voter', N.allLinks[link][voter].meta.weight
                        if N.allLinks[link][voter].meta?.weight?
                          unless typeof N.momentum[link] is 'number' or N.momentum[link] is 0
                            N.momentum[link] = 0
                          N.momentum[link] = N.momentum[link] + N.allLinks[link][voter].meta.weight - 5
                          # apply momentum calculation to object.. should be db level...
                          N.allLinks[link].momentum = N.momentum[link]
                        console.log N.momentum, 'N.momentum', N.momentum[link]

                    for vector of N.momentum
                      console.log vector, 'vector'
                    N.sortedLinks = linkstate.sortByMomentum N.linkSort, that.props.howMany
                    N.sortByWeight = linkstate.sortByWeight N.linkSort, that.props.howMany
                    console.log 'sorts', N.linkSort, N.sortByWeight
                    for timeLink in N.sortedLinks
                      console.log N.sortedLinks[timeLink]
                      D = {} # this link which has many users votes
                      D.N = N
                      D.link = timeLink
                      D.users = N.allLinks[timeLink]
                      D.firstUsersLink = D.users[Object.keys(D.users)[0]]
                      D.m = D.firstUsersLink.meta
                      U = {} # users votes loop object
                      U.D = D
                      U.usersConnections = N.inLinks[D.link]
                      k.build UrlBox,
                        D: D
                        N: N
                        U: U
                        from: that.props.from
                        to: that.props.to
                        props: that.props
                        thumbalizr: that.props.thumbalizr
                        word: that.props.word
                      #if N.inLinks[timeLink]?
                      #  console.log 'incomming link by', Object.keys(N.inLinks[timeLink]) , D.firstUsersLink
                    console.log N

preParseNode = (N) ->
  console.log N


exports.AboutCard = createContainer ((props) ->
  newProps = {}
  if props.from?
    Meteor.subscribe "Node", props.from
  N = Nodes.findOne(linkstate.store props.from)
  if N?
    newProps.node = N
    newProps.P = preParseNode N
  #console.log newProps.node, Nodes.find({}).count()
  props = _.extend {}, props, newProps
  props
), AboutCard
