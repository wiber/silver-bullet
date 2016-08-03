# Linking method on server and client..
{wordLanguages} = require('../ui/WebCopy.coffee')
language = 'eng'
mount = require('react-mounter').mount
{containerLayout} = require('../api/Layout.coffee')
FlowRouter.route '/about',
  name: 'home'
  action: (params, queryParams) ->
    # are FROM a new place, if so Link it to Bookmarks
    # this is not great for performance when page loads
    # this sort of performance can wait though as we need the consistency
    # if we ensure that this is done optimistically on client there should not be an issue
    samePlace = Meteor.user()?.fromLast != queryParams.from
    if Meteor.user() and samePlace and Meteor.isClient
      Meteor.call "Linking",
        from: decodeURIComponent queryParams.from
        to: 'Bookmarks'
        meta:
          title: queryParams.lastTitle
      , (error, result) ->
        if error
          console.log "error", error
        if result
          console.log 'result', result
    content = decodeURIComponent queryParams.content
    if content is 'undefined'
      content = ''
    console.log queryParams
    mount containerLayout,
      queryParams: queryParams # to optiomize redraw on changed params
      from: decodeURIComponent queryParams.from
      to: decodeURIComponent queryParams.to
      content: content
      fromTitle: decodeURIComponent queryParams.lastTitle
      word: wordLanguages[language] # don't prematurely optimize!
      expandMainCard: queryParams.expandMainCard == 'true'
      expandAboutCard: queryParams.expandAboutCard == 'true'
      expandMyCard: queryParams.expandMyCard == 'true'
