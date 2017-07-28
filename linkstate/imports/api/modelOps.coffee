{changeQueryParams,changeQueryParamsObject} = require '../api/changeQueryParams'

exports.userSaved = (userE, queryParams, client) ->
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



exports.nodeSaved = (userE, queryParams, client) ->
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

exports.newPlace = (user, queryParams, bookmarked) ->
  inBookmarks = user?.link?.to?.Bookmarks?[linkstate.store(queryParams.from)]?
  markExists = inBookmarks?.meta?
  console.log inBookmarks, markExists # false false..
  if bookmarked != 'true' and !markExists
    # must changeQueryParams here else it gets run multiple times
    changeQueryParams('Bookmarked', true)
    return true
  else
    return false

exports.ifBodyContentHere = (queryParams, user)->
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
