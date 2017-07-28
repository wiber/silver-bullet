{createContainer} = require 'meteor/react-meteor-data'
{wordLanguages} = require('../ui/WebCopy.coffee')
language = 'eng'
{Layout} = require '../ui/Layout.coffee'
{changeQueryParams} = require('../api/changeQueryParams.coffee')
{userSaved, newPlace,ifBodyContentHere} = require '../api/modelOps'
#{URI} = require 'urijs'
BookmarkTry = {}

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
  if newHere and Meteor.isClient
    payload =
      from: queryParams.from
      to: 'Bookmarks'
      meta:
        weight: 5
        title: queryParams.lastTitle#FlowRouter.getQueryParam('lastTitle')
    unless BookmarkTry.from is queryParams.from
      Meteor.call "Linking", payload
      BookmarkTry = payload

  if Meteor?.settings?.public?.thumbalizr?
    thumbalizr = Meteor.settings.public.thumbalizr
  else
    thumbalizr = undefined
  #content = ifBodyContentHere queryParams.content, queryParams, user
  newProps = {
    user: user
    thumbalizr: thumbalizr
    from: decodeURIComponent queryParams.from
    to: decodeURIComponent queryParams.to
    incomming: queryParams.incomming
    content: ifBodyContentHere(queryParams, user) #content
    lastTitle: queryParams.lastTitle
    word: wordLanguages[language] # don't prematurely optimize!
    expandMainCard: queryParams.expandMainCard != 'false'
    expandAboutCard: queryParams.expandAboutCard != 'false'
    expandMyCard: queryParams.expandMyCard != 'false'
  }
  newProps
), Layout
newPlace = (user, queryParams, bookmarked) ->
  inBookmarks = user?.link?.to?.Bookmarks?[linkstate.store(queryParams.from)]?
  markExists = inBookmarks?.meta?
  if bookmarked != 'true' and !markExists
    # must changeQueryParams here else it gets run multiple times
    changeQueryParams('Bookmarked', true)
    return true
  else
    return false

# does it not update on local
userSaved = (userE, queryParams, client) ->
  user = {}
  if !userE?.services?.facebook? and client
    u = JSON.parse(localStorage.getItem('latest'))
    window.saved = new Date().getTime()
    if u?
      user = u
  else
    if !window?.sub? and Meteor.isClient
      window.sub = new Date().getTime()
      time = (window.sub - window.saved)
      console.log time, 'ms of your load time saved by using localStorage'
    user = userE
  # sideffect but a good place to make sure we're not without direction
  for type in ['from', 'to']
    if queryParams[type] is undefined and client
      # double set them to avoid double render
      if user[type+'Last']?
        queryParams[type] = user[type+'Last']
        changeQueryParams(type, user[type+'Last'])
      else
        console.log " haven't connected to anything? how is that possible?"
  user
# textbox should have your comment in it if empty
# TODO write test for this
ifBodyContentHere = (queryParams, user)->
  paramContent = queryParams.content
  # we wish to dig up old content and fill in the box..
  #when a flag says we have changed FROM location
  # and we have old content on user object.
  # have we checked if there's content here?
  # last checked.. if last checked is.. then swap and do. on user object?

  if paramContent is 'undefined' or typeof paramContent is 'undefined'
    content = ''
  to = linkstate.store queryParams.to
  from = linkstate.store queryParams.from
  lastFrom = user?.lastFrom
  switched = lastFrom != queryParams.from
  cInExists = user?.link?.to?[to]?[from]?
  switchedPlace = FlowRouter.getQueryParam('switched') is 'true'
  if cInExists and switchedPlace
    cIn = user.link.from[to][from]
    #changeQueryParams 'content', cIn.meta.body # 'content', cIn,
    content = cIn.meta.body
  if typeof content is 'undefined'
    return ''
  else
    return content



exports.containerLayout = containerLayout
