{createContainer} = require 'meteor/react-meteor-data'
{wordLanguages} = require('../ui/WebCopy.coffee')
language = 'eng'
{Layout} = require '../ui/Layout.coffee'
{changeQueryParams} = require('../api/ModelOperations.coffee')
#{URI} = require 'urijs'
{newPlace, ifBodyContentHere, userSaved} = require '../api/ModelOperations'

containerLayout = createContainer ((props) ->
  queryParams = props.queryParams
  # store and use localStorage user untill user() received from server
  if Meteor.isClient
    Tracker.autorun ->
      userId = Meteor.userId()
      if !userId and UserHandle.ready() and localStorage
        localStorage.removeItem('latest')
      return
  user = userSaved(Meteor.user(), queryParams, Meteor.isClient)
  newHere = newPlace(user, queryParams, FlowRouter.getQueryParam('Bookmarked'))
  lastTitle =  FlowRouter.getQueryParam('lastTitle')
  # if newHere add this to the dropdown, set the to to lastTo
  if newHere and Meteor.isClient
    Meteor.call "Linking",
      from: queryParams.from
      to: 'Bookmarks'
      meta:
        weight: 5
        title: queryParams.lastTitle#FlowRouter.getQueryParam('lastTitle')
  if Meteor?.settings?.public?.thumbalizr?
    thumbalizr = Meteor.settings.public.thumbalizr
  else
    thumbalizr = undefined
  #content = ifBodyContentHere queryParams.content, queryParams, user
  newProps =
    user: user
    thumbalizr: thumbalizr
    queryParams: queryParams
    from: decodeURIComponent queryParams.from
    to: decodeURIComponent queryParams.to
    incomming: queryParams.incomming
    content: ifBodyContentHere(queryParams, user) #content
    lastTitle: queryParams.lastTitle
    word: wordLanguages[language] # don't prematurely optimize!
    expandMainCard: queryParams.expandMainCard != 'false'
    expandAboutCard: queryParams.expandAboutCard != 'false'
    expandMyCard: queryParams.expandMyCard != 'false'
    facebookAppId: Meteor.settings.public.facebookAppId
    newHere: newHere
    url: window.location.href
  #console.log newProps, queryParams.from, queryParams.to,'newProps, queryParams.from, queryParams.to'
  window.props = newProps
  newProps
), Layout



exports.containerLayout = containerLayout
