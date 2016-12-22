# imports/ui/mexplain.coffee shows a slideshow untill a user makes two connections
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
Slider = require('nuka-carousel')

exports.Mexplain = React.createClass
  render: ->
    that = this
    reactKup (k) ->
      unless that.props.hide
        k.build Card,
          style:
            height: 'auto'
          expandable: true
          mixins: [Slider.ControllerMixin]
          ->

            k.build Slider,
              style: Object.assign {},
                width: '100%'
              ->
                k.div 'inside'
                k.img
                  src: "http://placehold.it/1000x400/ffffff/c0392b/&text=slide1"
