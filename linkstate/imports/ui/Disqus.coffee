React = require 'react'
IconButton = require('material-ui/lib/icon-button').default #@material-ui/core/IconButton not working
RaisedButton = require('material-ui/lib/raised-button').default
TextField = require('material-ui/lib/TextField').default
{div, br, span} = React.DOM

exports.Disqus = React.createClass
  shouldComponentUpdate: (nextProps, nextState)->
    rerender = false
    oldUrl = @props.from
    newUrl = nextProps.from
    if oldUrl !=  newUrl
      rerender =  true
    rerender
  # componentDidUpdate: ->
  componentDidMount: ->
    window.disqus_config = ->
      @page.url = window.location
      # Replace PAGE_URL with your page's canonical URL variable
      # only identify comments by where we're from..
      @page.identifier = window.props.from
      # Replace PAGE_IDENTIFIER with your page's unique identifier variable
  componentDidUpdate: ->
    window.resetDisqus(window.props.from,window.location)
  render: ->
    div
      id: "disqus_thread"

###
disqus_config = ->
  console.log props.url, 'urlll',@props.from,@props,props
  #@page.url = props.url
  # Replace PAGE_URL with your page's canonical URL variable
  @page.identifier = @props.from
  #linkstate.store @props.from
  # Replace PAGE_IDENTIFIER with your page's unique identifier variable

  return

do ->
  # DON'T EDIT BELOW THIS LINE
  d = document
  s = d.createElement('script')
  s.src = 'https://decivote.disqus.com/embed.js'
  s.setAttribute 'data-timestamp', +new Date
  (d.head or d.body).appendChild s
  return
###
