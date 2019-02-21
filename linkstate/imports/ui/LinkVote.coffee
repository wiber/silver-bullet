#reactKup = require('react-kup')
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
    meta: React.PropTypes.object
    directed: React.PropTypes.bool
  render: ->
    that = this
    # #reactKup (k) ->
    if that.props.meta?.weight?
      positionOffset = -50
      imgHeightFunc = (c) -> 50*(1/Math.pow(1.66,c-1))
      imgHeight = imgHeightFunc(that.props.counted)
      diffHeight = 0
      # while making them smaller and smaller... their position needs to be adjusted..
      for i in [1..that.props.counted]
        if i > 1
          diffHeight = diffHeight + (imgHeightFunc(i-2) - imgHeightFunc(i-1))
      spanTop = (positionOffset+(that.props.counted + 0.25) * (that.props.size / 5)) - diffHeight/2
      imgTop = (positionOffset+that.props.counted * (that.props.size / 5)) - diffHeight/2
      if that.props.directed is 'INLINKS'
        bullet = '0 50% 50% 0'
      else
        bullet = '50% 0 0 50%'
      div ->
        span
        style:
          top: spanTop
          width: '100%' # 'auto'#
          left: 10
          color: 'rgb(255, 255, 255)'
          fontSize: '16px'
          position: 'absolute'
          backgroundColor: 'rgba(0, 0, 0, 0.2)'
        that.props.meta.body
        a
        href: that.props.meta.profileLink
        target: '_blank'
        img
          style: _.extend {},# style.webShot,
            top: imgTop
            width: 'auto'
            height: imgHeight
            #width: '10%' #style.scalars.screenshotWidth / 10
            left: 10 * that.props.meta.weight + '%'
            position: 'absolute'
            opacity: .5
            borderRadius: bullet
          src: that.props.meta.face.replace('http:','https:') if that?.props?.meta?.face?
exports.LinkVote = LinkVote
