R = require('ramda')
Lo = require 'lodash'
{linkstate} = require './strings'
oDict = {}
vDict = {}
#{changeQueryParams} = require 'changeQueryParams'
hereAndThere = (user, props) ->
  {from,to} = props
  HERE = Lo.get props, 'user.links.in.Bookmarks.' + linkstate.store(from)
  HereScreenshotUrl = Lo.get HERE, 'meta.ScreenshotUrl'
  unless HERE?
    HERE =
      title: props.lastTitle
      from: props.from
    console.log 'we are noplace', HERE
  THERE = Lo.get props, 'user.links.in.Bookmarks.' + linkstate.store(to)
  ThereScreenshotUrl = Lo.get THERE, 'meta.ScreenshotUrl'
  return {HERE, HereScreenshotUrl, THERE, ThereScreenshotUrl}

# we need a tested way to extract select options, and a particular option selected among them
setOptions = (props) ->
  options = []
  if props.user?.links?.out?
    # how titles get into selectize
    dictWithCreatedAt = props.user.links.in['Bookmarks']
    oDict = dictWithCreatedAt
    deChaos = linkstate.sortByKeysTime dictWithCreatedAt
    for index, value of deChaos
      continue if typeof value is not 'string'
      continue if value is 'undefined'
      continue unless dictWithCreatedAt[value]?.meta?.title?
      #continue unless dictWithCreatedAt[value].meta.weight > 0
      selectItem =
        label: dictWithCreatedAt[value].meta.title
        value: dictWithCreatedAt[value]
      options.push selectItem
  console.log options.length, props
  options

#FIXME does not select value when from a place
# to set value we need to know which type of select,
# which type of select we have

setValue = (props, options, user) ->
  if !props[props.type]
    userValue = user[props.type+'Last']
    console.log userValue
    console.log linkstate.store(props[props.type])
    BookmarkValue = Lo.get user, 'links.in.Bookmarks.'+linkstate.store(user[props.type+'Last'])
    console.log BookmarkValue
    console.log Lo.get BookmarkValue, 'meta.title'
    if BookmarkValue?
      return value =
        label: Lo.get BookmarkValue, 'meta.title'
        value: BookmarkValue
  else
    BookmarkValueProp = Lo.get user, 'links.in.Bookmarks.'+ linkstate.store props[props.type]
    console.log BookmarkValueProp
    return value =
      label: Lo.get BookmarkValueProp, 'meta.title'
      value: BookmarkValueProp
  newProps = {}
  newProps.options = []
  value = {}
  bookmarked = props.user?.links?.in?.Bookmarks?
  return unless bookmarked
  #directedTo = typeof props.to is 'string' and props.to.length > 1
  clientReady = props.user?.services?.facebook?# and Meteor.isClient
  gotFrom = typeof props.from is 'string' and props.from.length > 1

  dictWithCreatedAt = user.links.in['Bookmarks']
  #vDict = dictWithCreatedAt
  typeValue = props[props.type]
  dictValue = dictWithCreatedAt[linkstate.store(typeValue)]
  dictValueExists = dictValue?.meta?.title?
  lastDictValue = dictWithCreatedAt[linkstate.store(user[props.type+'Last'])]
  setLastTitle = true if props.newHere
  console.log linkstate.store user.toLast
  dictValueUsertoLast = dictWithCreatedAt[linkstate.store user.toLast]
  # if we're in a new place, we want to point to the last place we connected to
  # do we simply walk backwards untill we find a place not here?
  # the problem is pointing to.. we are getting the wrong to value
  # make negative cases...
  # negative cases, return user.toLast if no to..
  # case 1: qp exist but not
  console.log props.to, props.from
  if props.type is 'to' and !props.to?
    return value =
      label: lastDictValue.meta.title
      value: lastDictValue
  if props.type is 'from'
    if dictValueExists
      title = 'Linkstates for ' + dictValue.title + ' - ' + props.from
      #DocHead.setTitle(title) # needs attention
      if document?
        document.title = title
  if dictValueExists# and clientReady
    return value =
      label: dictValue.meta.title
      value: dictValue
  else
    return value =
      label: props.lastTitle
      value:
        meta:
          FromLink: props.from
          title: props.lastTitle

  #value
# we need a schema for writes and reads from the same place
ModelNamespaces =
  bookmarks: 'links.in.Bookmarks.'
# need to mock the actual method start sequence..
newPlace = (user, queryParams, bookmarked) ->
  inBookmarks = Lo.get user, ModelNamespaces.bookmarks + linkstate.store(queryParams.from)
  #user?.out?.Bookmarks?[linkstate.store(queryParams.from)]
  markExists = inBookmarks?.meta?
  if bookmarked != 'true' and !markExists
    # must changeQueryParams here else it gets run multiple times
    changeQueryParams('Bookmarked', true)
    return true
  else
    return false


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
    if queryParams[type] is undefined
      # double set them to avoid double render
      console.log type, 'is undefined'
      if user[type+'Last']?
        #queryParams[type] = user[type+'Last']
        changeQueryParams(type, user[type+'Last'])
      else
        console.log 'have not connected to anything? how is that possible?'
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
  cInExists = user?.out?[to]?[from]?
  switchedPlace = FlowRouter.getQueryParam('switched') is 'true'
  if cInExists and switchedPlace
    cIn = user.out[to][from]
    #changeQueryParams 'content', cIn.meta.body # 'content', cIn,
    content = cIn.meta.body
  if typeof content is 'undefined'
    return ''
  else
    return content

changeQueryParams = (key,value) ->
  if typeof FlowRouter.setQueryParams is 'function'
    newQueryParams = {}
    newQueryParams[key] = value
    from = key is 'from'
    to = key is 'to'
    if key is 'from' #or key is 'to'
      if FlowRouter.getQueryParam(key) != value
        exports.changeQueryParams('switched','true')
    if FlowRouter.getQueryParam(key) is value
      # else we break back button with non moves
      return
    else
      FlowRouter.setQueryParams newQueryParams

changeQueryParamsObject = (changes) ->
  #changeFunc = (value,key, obj) ->
  #  exports.changeQueryParams key, value
  #R.mapObjIndexed changeFunc, changes
  for key, value of changes
    exports.changeQueryParams key, value

exports.changeQueryParamsObject= changeQueryParamsObject
exports.changeQueryParams = changeQueryParams
exports.hereAndThere = hereAndThere
exports.setValue = setValue
exports.setOptions = setOptions
exports.newPlace = newPlace
exports.userSaved = userSaved
exports.ifBodyContentHere = ifBodyContentHere
exports.ModelNamespaces = ModelNamespaces
