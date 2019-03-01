# imports/ui/mexplain.coffee shows a slideshow untill a user makes two connections
#reactKup = require('react-kup')
React = require('react')
{style} = require('../ui/style.coffee')
# {changeQueryParams} = require('../api/changeQueryParams.coffee')
Card = require('@material-ui/core/Card').default
# CardActions = require('material-ui/lib/card/card-actions' ).default
CardHeader = require('@material-ui/core/CardHeader').default
# CardMedia = require('material-ui/lib/card/card-media').default
# CardTitle = require('material-ui/lib/card/card-title').default
# {Subheader} = require 'material-ui/lib/Subheader'
# {StarBorder} = require 'material-ui/lib/svg-icons/toggle/star-border'
Slider = require('nuka-carousel')
CardText =  require('@material-ui/core/CardContent').default #change CardText To CardContent
# set the attr to a still on all, then, swap in the live one.. else flicker
# # {AccountsUIWrapper} = require '../ui/AccountsUIWrapper.coffee'

resetSlides = () ->
  for e in $('.gifSlide')
    el = $(e)
    el.attr 'src', 'empty'
    el.attr 'src', el.attr 'href'
gifSlide = React.createClass
  # sounds costly, but only predictable way to do it
  componentDidMount: resetSlides
  render: ->
    that = this
    # #reactKup (k) ->
    div ->
      img
        id: 'Nuka'+that.props.slideNumber
        className: 'gifSlide'
        "style":{
          "width": '100%'
          "height": 300
        }
        src: that.props.src
        href: that.props.src
        ref: 'Nuka'+that.props.slideNumber


exports.Mexplain = React.createClass
  render: ->
    that = this
    # #reactKup (k) ->
    React.createElement Card,{
      "style": _.extend {}, style.card, style.yCard,
      "height": '470'
    }
    
    #expanded: that.props.hide
    #expandable: true
    mixins: [Slider.ControllerMixin]
    ->
      React.createElement CardHeader,{
        "title": that.props.word.MexplainTitle
        # showExpandableButton: true
        "subtitle": that.props.word.MexplainSubtitle
      }
      onClick: (e) ->
        window.open '/login', "_blank"

      React.createElement CardText,
        ->
          React.createElement Slider,{
            #tabIndex: -1
            "ref": 'nuka-carousel'
            "style": Object.assign {},
              "height": 300
              "width": 'auto'
              #width: 610
          }
          "autoplay": false
          "autoplayInterval": 5000
          "initialSlideHeight": 480
          "framePadding": 0
          "wrapAround": true
          "dragging": true
          "slideIndex": that.props.slideIndex or 0
          "beforeSlide": resetSlides
          #componentDidMount: resetSlides # problematic
          ->
            React.createElement gifSlide,{
              "src": '/carousel/s1whysense.gif'
              "slideNumber": 0
            }
            React.createElement gifSlide,{
              "src": '/carousel/s2duo.gif'
              "slideNumber": 1
            }
            React.createElement gifSlide,{
              "src": '/carousel/slide3c.gif'
              "slideNumber": 2
            }
