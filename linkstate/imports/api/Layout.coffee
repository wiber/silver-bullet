{createContainer} = require 'meteor/react-meteor-data'
{wordLanguages} = require('../ui/WebCopy.coffee')
language = 'eng'
{Layout} = require '../ui/Layout.coffee'
{changeQueryParams,changeQueryParamsObject} = require('../api/ModelOperations.coffee')
#{URI} = require 'urijs'
{newPlace, ifBodyContentHere, userSaved, simpleUrl, hereAndThere,hereToThereMeta,theModel} = require '../api/ModelOperations'

{ Meteor } = require 'meteor/meteor'
{linkstate} = require '../api/strings'
containerLayout = createContainer ((props) ->
  queryParams = props.queryParams
  {from,to,bookmarked,lastTitle} = queryParams
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
  markExist = linkstate.bookmarkExistHere user, queryParams.from
  # break these out into meteor methods -
  # named and knowing weather it's the first visit etc
  # eventing system?
  if newHere or !markExist and Meteor.isClient
    # console.log queryParams.from, linkstate.catTree.categoryUrls.Bookmarks
    Meteor.call "Linking",
      from: queryParams.from
      to: linkstate.catTree.categoryUrls.Bookmarks
      meta:
        weight: 5
        title: queryParams.lastTitle#FlowRouter.getQueryParam('lastTitle')
    changeQueryParamsObject
      title: queryParams.lastTitle
    document.title = "Linkstate @ "+queryParams.lastTitle
  else
    # set title - here meta title
    #herethere = hereToThereMeta user, queryParams
    #model = theModel queryParams
    bookmark = linkstate.getTheBookmark user, queryParams.from
    #console.log {bookmark,herethere,user, queryParams,markExist,newHere}
    document.title = "Linkstate for "+bookmark.title
    changeQueryParamsObject
      title: bookmark.title


  if Meteor?.settings?.public?.thumbalizr?
    thumbalizr = Meteor.settings.public.thumbalizr
  else
    thumbalizr = undefined
  #content = ifBodyContentHere queryParams.content, queryParams, user
  console.log {user,from},!!from,{from,to,bookmarked,lastTitle}
  # TODO rewrite this so the default case is to use the meteor user to set params
  # over write with params if they exist
  # figure out if the app was loaded by copying the url... how?

  newProps =
    user: user
    thumbalizr: thumbalizr
    queryParams: queryParams
    from: decodeURIComponent queryParams.from or user.fromLast
    to: decodeURIComponent queryParams.to or user.toLast
    incomming: queryParams.incomming
    content: ifBodyContentHere(queryParams, user) #content
    lastTitle: queryParams.lastTitle
    word: wordLanguages[language] # don't prematurely optimize!
    #expandMainCard: queryParams.expandMainCard != 'false'
    #expandAboutCard: queryParams.expandAboutCard != 'false'
    #expandMyCard: queryParams.expandMyCard != 'false'
    facebookAppId: Meteor.settings.public.facebookAppId
    newHere: newHere
    url: simpleUrl(queryParams)#window.location.href
  #console.log newProps, queryParams.from, queryParams.to,'newProps, queryParams.from, queryParams.to'
  window.props = newProps
  newProps
), Layout



exports.containerLayout = containerLayout
