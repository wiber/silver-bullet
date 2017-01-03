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
{Subheader} = require 'material-ui/lib/Subheader'
{StarBorder} = require 'material-ui/lib/svg-icons/toggle/star-border'
Slider = require('nuka-carousel')

exports.Mexplain = React.createClass
  render: ->
    that = this
    reactKup (k) ->
      unless that.props.hide
        k.build Card,
          style: _.extend {}, style.card, style.yCard,
            height: 'auto'
          expandable: true
          mixins: [Slider.ControllerMixin]
          ->
            k.build Slider,
              ref: 'nuka-carousel'
              style: Object.assign {},
                height: 'auto'
                width: 610
              autoplay: false
              autoplayInterval: 3000
              initialSlideHeight: 480
              framePadding: 0
              wrapAround: true
              dragging: true
              slideIndex: that.props.slideIndex or 0
              #data: -> this.setCarouselData.bind(this, 'carousel')
              afterSlide: ->
                console.log this, this.slideIndex, this.state
              ->
                k.div ->
                  k.img
                    src: '/carousel/bdeadtrue.gif'
                    style:
                      marginLeft: '0%'
                k.div ->
                  k.h1 'Yes. Bookmarks are dead.'
                  k.br
                  k.h2 'But you still need somewhere to organize stuff. Feel me?'
