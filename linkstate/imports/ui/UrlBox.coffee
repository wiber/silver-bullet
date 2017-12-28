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
{LinkVote} = require '../../imports/ui/LinkVote.coffee'
{GoMark} = require '../../imports/api/nav/GoMark.coffee'
{Winged} = require '../ui/ShadowMoon'
R = require 'ramda'

# how does one break this one up?
UrlBox = React.createClass
  propTypes:
    D: React.PropTypes.object
  render: ->
    that = this
    reactKup (k) ->
      {N,dotlessLink,thumbalizr,user,word,from,to,ScreenshotUrl} = that.props
      usersLinks = N.allLinks[dotlessLink]
      # more correct to sort by date.. but why..
      firstUserHere = Object.keys(usersLinks)[0]
      #  at least one of the node ends points to here.
      if N.node.links.in[dotlessLink]? and N.node.links.out[dotlessLink]?
        firstWibeHere = usersLinks[firstUserHere]
        console.log "# we don't want to draw two if there's a self reference",firstWibeHere
        type = 3
      else
        if N.node.links.in[dotlessLink]?
          firstWibeHere = N.node.links.in[dotlessLink][Object.keys(N.node.links.in[dotlessLink])[0]]
          firstWibeHere.subtitle = firstWibeHere.meta.FromLink
          type = 2
        else
          if N.node.links.out[dotlessLink]?
            firstWibeHere = N.node.links.out[dotlessLink][Object.keys(N.node.links.out[dotlessLink])[0]]
            firstWibeHere.subtitle = firstWibeHere.meta.ToLink
            type = 1
          else
            type = 0
            firstWibeHeresubtitle = ''
            console.error 'very strange not to have either in or out. is the link in a bad format?'
      # are we looking at this because it points to or from this place?
      # we have to cycle through both to and fros.. but we only show the other end
      #console.log  firstUserHere, firstWibeHere, firstWibeHere.meta.title, type
      k.build GridTile,
        title: firstWibeHere.meta.title
        subtitle: firstWibeHere.subtitle #D.m.FromLink#[that.props.type]#that.props.word.to + D.m.ToLink
        onClick: (e) ->
          GoMark
            type:
              from: firstWibeHere.meta.FromLink
              to: firstWibeHere.meta.ToLink
            N: N.node
            user: that.props.user
        ->
          k.build Winged,
            ScreenshotUrl: firstWibeHere.meta.ScreenshotUrl # because.. it's picked
            user: that.props.user
            from: that.props.from #firstWibeHere.meta.FromLink#
            firstWibeHere: firstWibeHere
            measurements:
              D: 300
              d: 60
              M: 50
            N: N

oldBullet = React.createClass
  render: ->
    reactKup (k) ->
      k.div ->
        k.div
          style: style.fromBullet
          ->
            k.img
              style: _.extend {}, style.webShot,
                opacity: .7
                zIndex: 2
              src: linkstate.thumbalizrPic D.m.FromLink
        k.img
          style: _.extend {}, style.webShot,
            position: 'absolute'
            left: '30%'
            zIndex: -1
          src:linkstate.thumbalizrPic D.m.ToLink
      inlink = N.inLinks?[D.link]?
      outlink = N.outLinks?[D.link]?
      U = {}
      U.directionUserMeta = {}
      if outlink
        U.directionUserMeta.OUTLINKS = N.outLinks[D.link]
      if inlink
        U.directionUserMeta.INLINKS = N.inLinks[D.link]
      counted = 0
      for directedBunch of U.directionUserMeta
        for userVectorName of U.directionUserMeta[directedBunch]
          counted++
          k.build LinkVote,
            counted: counted
            size: style.scalars.screenshotWidth
            meta: U.directionUserMeta[directedBunch][userVectorName].meta
            directed: directedBunch
exports.UrlBox = UrlBox
###
something broken with these queryParams
http://localhost:3000/about?Bookmarked=true&content=asdasd&from=http%253A%252F%252Fwww.material-ui.com%252Fv0.15.0%252F%2523%252Fcomponents%252Fgrid-list&expandMyCard=true&expandMexplain=true&expandAboutCard=true&to=http%253A%252F%252Fwww.material-ui.com%252Fv0.15.0%252F%2523%252Fcomponents%252Fgrid-list&switched=
http://localhost:3000/about?
Bookmarked=true
&content=asdasd
&from=http%253A%252F%252Fwww.material-ui.com%252Fv0.15.0%252F%2523%252Fcomponents%252Fgrid-list
&expandMyCard=true&
expandMexplain=true
&expandAboutCard=true
&to=http%253A%252F%252Fwww.material-ui.com%252Fv0.15.0%252F%2523%252Fcomponents%252Fgrid-list
&switched=

# inLinks / url / user / wibe
if timeLink? and timeLink is that.props.from and N.allLinks[timeLink]? # !D.users?
# we are interested in the one that is not where we are now,
# but has connections to or from it.
D = {}
D.N = N
D.link = timeLink
D.users = N.allLinks[timeLink]
console.log
console.log Object.keys(D.users),Object.keys(D.users)[0]
D.firstUsersLink = D.users[Object.keys(D.users)[0]]
D.m = D.firstUsersLink.meta
#console.log typeof D.users
console.log  D.users,Object.keys(D.users)[0], timeLink
U = {} # users votes loop object
U.D = D
console.log D, D.link
U.usersConnections = N.inLinks[D.link]
# needs to know this url in the loop, and what page we're on so it can avoid drawing... two?
# needs the node object
# needs to draw the big circle and the small circles

else
console.log 'not interested in links here, only who linked it to other places'
###
