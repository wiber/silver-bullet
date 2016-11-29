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


LinkVote = React.createClass
  propTypes:
    linkVote: React.PropTypes.object
    V: React.PropTypes.object
    from: React.PropTypes.string
    to: React.PropTypes.string
  render: ->
    that = this
    console.log that.props, 'sent to linkVote'
    reactKup (k) ->
      V = that.props.V
      if that.props.from is V.vote.meta.FromLink
        bullet = '0 50% 50% 0'
      else
        bullet = '50% 0 0 50%'
      k.div ->
        k.span
          style:
            top: (V.counted + 0.25) * (V.size / 5)
            width: '100%' # 'auto'#
            left: 10
            color: 'rgb(255, 255, 255)'
            fontSize: '16px'
            position: 'absolute'
            backgroundColor: 'rgba(0, 0, 0, 0.2)'
          V.vote.meta.body
        k.a
          href: V.vote.meta.profileLink
          target: '_blank'
          k.img
            style: _.extend {},# style.webShot,
              top: V.counted *(V.size / 5)
              #width: '10%' #style.scalars.screenshotWidth / 10
              left: 10 * V.vote.meta.weight + '%'
              position: 'absolute'
              opacity: .5
              borderRadius: bullet # '0 50% 50% 0'
            src: V.vote.meta.face
exports.LinkVote = LinkVote
