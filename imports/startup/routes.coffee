# Linking method on server and client..
{wordLanguages} = require('../ui/WebCopy.coffee')
language = 'eng'
mount = require('react-mounter').mount
{containerLayout} = require('../api/Layout.coffee')
{linkstate} = require '../api/strings.coffee'
FlowRouter.route '/about',
  name: 'home'
  action: (params, queryParams) ->
    #console.log linkstate.urlT('http://www.w3schools.com/jsref/jsref_search.asp') == linkstate.urlT(linkstate.urlT(linkstate.urlT('http://www.w3schools.com/jsref/jsref_search.asp')))
    unless !queryParams.from
      one = linkstate.urlT queryParams.from
      two = linkstate.urlT one
      three = linkstate.urlT two
      console.log 'checking', one == three, queryParams.from == two
    console.log params, queryParams
    mount containerLayout,
      #from: queryParams.from
      from: linkstate.urlT queryParams.from
      to: queryParams.to
      word: wordLanguages[language] # don't prematurely optimize!
      expandMainCard: queryParams.expandMainCard == 'true'
      expandAboutCard: queryParams.expandAboutCard == 'true'
      expandMyCard: queryParams.expandMyCard == 'true'
