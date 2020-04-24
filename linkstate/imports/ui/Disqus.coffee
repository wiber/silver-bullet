React = require 'react'
IconButton = require('material-ui/lib/icon-button').default #@material-ui/core/IconButton not working
RaisedButton = require('material-ui/lib/raised-button').default
TextField = require('material-ui/lib/TextField').default
{div, br, span} = React.DOM
exports.DisqusConfig = (from) ->
  if window? and window?.document?
    disqus_config = ->
      @page.url = window.location
      # Replace PAGE_URL with your page's canonical URL variable
      @page.identifier = linkstate.store from
      # Replace PAGE_IDENTIFIER with your page's unique identifier variable
      return
    unless window.disqusLoaded
      do ->
        # DON'T EDIT BELOW THIS LINE
        d = document
        s = d.createElement('script')
        s.src = 'https://decivote.disqus.com/embed.js'
        s.setAttribute 'data-timestamp', +new Date
        (d.head or d.body).appendChild s
        window.disqusLoaded = true

exports.Disqus = React.createClass
  componentDidMount: ->
    script = document.createElement('script')
    script.src = "//decivote.disqus.com/count.js"
    script.async = true
    script.id = "dsq-count-scr"
    document.body.appendChild script
    window.resetDisqus = (newIdentifier, newUrl, newTitle, newLanguage) ->
      console.log 'DISQUS reload',{newIdentifier, newUrl, newTitle, newLanguage}
      DISQUS.reset
        reload: true
        config: ->
          @page.identifier = newIdentifier
          @page.url = newUrl
          @page.title = newTitle#{}"Linkstates for "+document.title
          console.log {@page,DISQUS,'loading DISQUS'}
          #@language = newLanguage
          ###
          shortname
          this.page.identifier
          this.page.title
          this.page.url
          this.page.category_id
          ###
  shouldComponentUpdate: (nextProps, nextState)->
    rerender = false
    oldUrl = @props.from
    newUrl = nextProps.from
    if oldUrl !=  newUrl
      rerender =  true
    rerender
  # componentDidUpdate: ->
  componentDidUpdate: ->
    # can't find a better way ...
    console.log 'componentDidUpdate DISQUS', @props.from, props.from
    window.resetDisqus(window.props.from,window.location,"Linkstates for "+document.title)
  render: ->
    div
      id: "disqus_thread"
      arbitraryThing: props.from

###

https://linkstate.youiest.com/about?from=https%3A%2F%2Fdocs.google.com%2Fdocument%2Fd%2F1xeOzeZ3CyD_mlCGP6Sy41p19xZ49PeE1bZ3ZE6n4WSY%2Fedit%23&lastTitle=7%20Stages%20-%20Target%20Audience%20-%20Google%20Docs&to=https%3A%2F%2Fwww.youtube.com%2Fwatch%3Fv%3DJNNfeqt9BAU&Bookmarked=true&title=7%20Stages%20-%20Target%20Audience%20-%20Google%20Docs&content=&switched=
https://linkstate.youiest.com/about?from=https%3A%2F%2Fdocs.google.com%2Fdocument%2Fd%2F1xeOzeZ3CyD_mlCGP6Sy41p19xZ49PeE1bZ3ZE6n4WSY%2Fedit%23&lastTitle=7%20Stages%20-%20Target%20Audience%20-%20Google%20Docs&to=https%3A%2F%2Fwww.youtube.com%2Fwatch%3Fv%3DJNNfeqt9BAU&Bookmarked=true&title=7%20Stages%20-%20Target%20Audience%20-%20Google%20Docs&content=&switched=
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
