# Linking method on server and client..
{wordLanguages} = require('../ui/WebCopy.coffee')
language = 'eng'
mount = require('react-mounter').mount
{containerLayout} = require('../api/Layout.coffee')
FlowRouter.route '/about',
  name: 'home'
  action: (params, queryParams) ->
    if Meteor.userId() and Meteor.isClient and typeof Meteor.user().services is 'object' #and typeof Meteor.user().services.facebook is 'object'
      # 'from' is a global db object here with a huge dict of last time each user newtab from a certain url
      # we do this on the client to enforce the state of strings
      # the most recent newtab item
      console.log linkstate.sortByKeysTime(Meteor.user().out[Meteor.userId()])[0], queryParams.from, 'Linked From'#, result
      Meteor.call "Linking"
      , queryParams.from, Meteor.user().services.facebook.email
      , (error, result) ->
        if error
          console.log "error", error
        if result
          console.log
          console.log linkstate.sortByKeysTime(Meteor.user().out[Meteor.userId()])[0], queryParams.from, 'Linked From', result



    console.log queryParams.from, 'to', queryParams.to#, 'whole', queryParams
    mount containerLayout,
      from: queryParams.from
      to: queryParams.to
      content: queryParams.content
      word: wordLanguages[language] # don't prematurely optimize!
      expandMainCard: queryParams.expandMainCard == 'true'
      expandAboutCard: queryParams.expandAboutCard == 'true'
      expandMyCard: queryParams.expandMyCard == 'true'

###
unless !Meteor.userId()
  Meteor.call "Linking", queryParams.from, Meteor.userId(), (error, result) ->
    if error
      console.log "error", error
###
