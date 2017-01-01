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

UrlBox = React.createClass
  propTypes:
    D: React.PropTypes.object
  render: ->
    that = this
    console.log that.props, 'sent to UrlBox'
    reactKup (k) ->
      D = that.props.D
      N = that.props.N
      U = that.props.U
      thumbalizr = that.props.thumbalizr
      k.build GridTile,
        key: D.link+'Node'
        title: D.m.title
        subtitle: that.props.word.to + D.m.ToLink
        ->
          k.div ->
            k.div
              style: style.fromBullet
              ->
                k.img
                  style: _.extend {}, style.webShot,
                    opacity: .7
                    zIndex: 2
                  src: linkstate.thumbalizrPic D.m.FromLink
                  from: D.m.FromLink
                  onClick: (e) ->
                   changeQueryParams 'from', e.target.getAttribute('from')
            k.img
              style: _.extend {}, style.webShot,
                position: 'absolute'
                left: '30%'
                zIndex: -1
              src:linkstate.thumbalizrPic D.m.ToLink
              to: D.m.ToLink
              onClick: (e) ->
               changeQueryParams 'to', e.target.getAttribute('to')
          if N.inLinks?[D.link]?
            U.linksByTimeUsers = linkstate.sortByKeysTime(U.usersConnections)
            console.log U
            V = {}
            V.U = U
            V.counted = 0
            for user in U.linksByTimeUsers
              V.user = user
              console.log V
              V.vote = U.usersConnections[V.user]
              V.size = size = style.scalars.screenshotWidth
              console.log V
              if V.vote?.meta?
                k.build LinkVote,
                  from: that.props.from
                  V: V

exports.UrlBox = UrlBox
