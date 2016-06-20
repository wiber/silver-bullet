# Linking method on server and client..
{wordLanguages} = require('../ui/WebCopy.coffee')
language = 'eng'
mount = require('react-mounter').mount
{containerLayout} = require('../api/Layout.coffee')
FlowRouter.route '/about',
  name: 'home'
  action: (params, queryParams) ->
    # this is not great for performance when page loads
    # this sort of performance can wait though as we need the consistency
    # if we ensure that this is done optimistically on client there should not be an issue
    #console.log queryParams.from?
    if Meteor.isClient and Meteor.userId()? and queryParams.from?
      Meteor.call "Linking"
      , decodeURIComponent(queryParams.from)
      , 'Jump-List'
      , (error, result) ->
    mount containerLayout,
      from: decodeURIComponent queryParams.from
      to: decodeURIComponent queryParams.to
      content: queryParams.content
      word: wordLanguages[language] # don't prematurely optimize!
      expandMainCard: queryParams.expandMainCard == 'true'
      expandAboutCard: queryParams.expandAboutCard == 'true'
      expandMyCard: queryParams.expandMyCard == 'true'

###
unless !Meteor.userId()
  Meteor.call "Linking", queryParams.from, Meteor.userId(), (error, result) ->
    if error
      #console.log "error", error
###
