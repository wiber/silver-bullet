{createContainer} = require 'meteor/react-meteor-data'
{wordLanguages} = require('../ui/WebCopy.coffee')
language = 'eng'
{Layout} = require '../ui/Layout.coffee'
{changeQueryParams} = require('../api/changeQueryParams.coffee')
containerLayout = createContainer ((props) ->
  queryParams = props.queryParams
  # store and use localStorage user untill user() received from server
  user = userSaved(Meteor.user(), queryParams, Meteor.isClient)

  if newPlace(user, queryParams, FlowRouter.getQueryParam('Bookmarked')) and Meteor.isClient
    # and UserHandle.ready()

    Meteor.call "Linking",
      from: queryParams.from
      to: 'Bookmarks'
      meta:
        weight: 5
        title: queryParams.lastTitle
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
  #console.log 'newProps',newProps, newProps?.content?.length?, FlowRouter.getQueryParam('content')?.length?
  newProps
), Layout

newPlace = (user, queryParams, bookmarked) ->
  inBookmarks = user.out?.Bookmarks?[linkstate.store(queryParams.from)]
  markExists = inBookmarks?.meta?
  if bookmarked != 'true' and !markExists
    # must changeQueryParams here else it gets run multiple times
    changeQueryParams('Bookmarked', true)
    #console.log 'From a new place! Bookmark it!', FlowRouter.getQueryParam('Bookmarked')
    return true
  else
    #console.log 'Been here before.. !bookmarked, !markExists', !bookmarked, !markExists
    return false


userSaved = (userE, queryParams, client) ->
  if !userE?.services?.facebook? and client
    u = JSON.parse(localStorage.getItem('latest'))
    window.saved = new Date().getTime()
    if u?
      user = u
    else
      user = {}
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
      queryParams[type] = user[type+'Last']
      changeQueryParams(type, user[type+'Last'])
  user
# textbox should have your comment in it if empty
ifBodyContentHere = (queryParams, user)->
  paramContent = queryParams.content
  # we wish to dig up old content and fill in the box.. when a flag says we have changed FROM location
  # and we have old content on user object.
  # have we checked if there's content here?
  # last checked.. if last checked is.. then swap and do. on user object?

  if paramContent is 'undefined' or typeof paramContent is 'undefined'
    content = ''
  to = linkstate.store queryParams.to
  from = linkstate.store queryParams.from
  lastFrom = user.lastFrom
  switched = lastFrom != queryParams.from
  cInExists = user?.out?[to]?[from]?

  if cInExists and switched
    cIn = user.out[to][from]
    #changeQueryParams 'content', cIn.meta.body # 'content', cIn,
    content = cIn.meta.body
  #console.log from, to, lastFrom, switched, cInExists, cIn, content
  if typeof content is 'undefined'
    return ''
  else
    return content



exports.containerLayout = containerLayout
