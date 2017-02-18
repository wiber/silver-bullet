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
# set the attr to a still on all, then, swap in the live one.. else flicker

gifSlide = React.createClass
  render: ->
    that = this
    reactKup (k) ->
      k.div ->
        k.img
          id: 'Nuka'+that.props.slideNumber
          className: 'gifSlide'
          style:
            width: '100%'
            height: 'auto'
          src: that.props.src
          href: that.props.src
          ref: 'Nuka'+that.props.slideNumber

exports.Mexplain = React.createClass
  render: ->
    else
      that = this
      reactKup (k) ->
        k.build Card,
          expanded: that.props.hide
          style: _.extend {}, style.card, style.yCard,
            height: '380'
          expandable: true
          mixins: [Slider.ControllerMixin]
          ->
            k.build Slider,
              ref: 'nuka-carousel'
              style: Object.assign {},
                height: 'auto'
                width: 610
              autoplay: false
              autoplayInterval: 5000
              initialSlideHeight: 480
              framePadding: 0
              wrapAround: true
              dragging: true
              slideIndex: that.props.slideIndex or 0
              beforeSlide: ->
                # restart all the gifs
                for e in $('.gifSlide')
                  el = $(e)
                  el.attr 'src', 'empty'
                  el.attr 'src', el.attr 'href'
              ->
                k.build gifSlide,
                  src: '/carousel/s1whysense.gif'
                  slideNumber: 0
                k.build gifSlide,
                  src: '/carousel/s2duo.gif'
                  slideNumber: 1
                k.build gifSlide,
                  src: '/carousel/slide3c.gif'
                  slideNumber: 2
