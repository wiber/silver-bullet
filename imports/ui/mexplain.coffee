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

gifSlide = React.createClass
  render: ->
    that = this
    reactKup (k) ->
      k.div ->
        k.img
          id: 'Nuka'+that.props.slideNumber
          style:
            width: '100%'
            height: 'auto'
          src: that.props.src
          ref: 'Nuka'+that.props.slideNumber
        console.log $('#Nuka'+that.props.slideNumber)

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
              autoplay: true
              autoplayInterval: 5000
              initialSlideHeight: 480
              framePadding: 0
              wrapAround: true
              dragging: true
              slideIndex: that.props.slideIndex or 0
              afterSlide: ->
                # restart the gif animation when slide is brought into view
                slide = that.refs['nuka-carousel'].state.currentSlide
                if slide?
                  slideElement = $('#Nuka'+slide)
                  src = slideElement.attr 'src'
                  slideElement.attr 'src', 'null'
                  slideElement.attr 'src', src
              ->
                k.build gifSlide,
                  src: '/carousel/s1short.gif'
                  slideNumber: 1
                k.build gifSlide,
                  src: '/carousel/s2commentshort.gif'
                  slideNumber: 2
                k.build gifSlide,
                  src: '/carousel/slide3c.gif'
                  slideNumber: 3
                k.div
                  style:
                    padding: 35
                  ->
                    k.h1 'Making connections is '
                    k.br
                    k.h2 'But you still need somewhere to organize stuff. Feel me?'
