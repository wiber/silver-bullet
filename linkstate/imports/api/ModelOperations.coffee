R = require('ramda')
_ = require 'lodash'
{linkstate} = require './strings'
if typeof linkstate is undefined
  console.log 'error linkstate'
oDict = {}
vDict = {}
{changeQueryParams} = require '../api/changeQueryParams'
{see, store, linkstate} = require '../api/strings'
{catTree} = linkstate

# we need a function that takes props, user
# and returns full state of the app model.
theModel = (props) ->
  {HERE,HereScreenshotUrl,THERE,ThereScreenshotUrl} = hereAndThere(props, props.user)

  returnThis = {HERE,HereScreenshotUrl,THERE,ThereScreenshotUrl,options,value,props}
  console.log returnThis,'theModel'
  returnThis
hereToThereMeta = (user,props) ->
  {from, to} = props
  storeFrom = linkstate.store from
  storeTo = linkstate.store to
  getMeta = _.property ['links','in',storeFrom,storeTo]
  getMetaWeight = _.property ['links','out',storeFrom,storeTo,'meta','weight']
  hereToThereObj = getMeta user
  hereToThereObjWeight = getMetaWeight user
  {hereToThereObj, hereToThereObjWeight}

hereAndThere = (user, props) ->
  {from,to, user} = props
  #console.log {from,to, user},'should not first'
  HERE = linkstate.getTheBookmark user, from
  HereScreenshotUrl = linkstate.getTheScreenshot HERE
  unless HERE?
    HERE =
      title: props.lastTitle
      from: props.from
      meta:
        screenshoturl: 'nothing'
    console.log 'we are noplace', HERE
  bookmarkDict = linkstate.getAllBookmarksDict props.user
  targetO = _.get bookmarkDict, linkstate.store(to) #bookmarkDict[linkstate.store(to)]
  THERE = _.get bookmarkDict, linkstate.store(to)
  # could be an issue
  try
    ThereScreenshotUrl = _.get targetO, 'meta.ScreenshotUrl'
  catch error
    console.error targetO, '501 no attribute .ScreenshotUrl'
    ThereScreenshotUrl = _.get targetO, 'meta.ScreenshotUrl'
  return {HERE, HereScreenshotUrl, THERE, ThereScreenshotUrl}

# we need a tested way to extract select options, and a particular option selected among them
setOptions = (props) ->
  options = []
  #return false if !props.user?.links?.in?
  # how titles get into selectize
  bookmarks = linkstate.getAllBookmarksDict props.user
  deChaos = linkstate.sortByKeysTime(bookmarks)
  for index, value of deChaos
    #break if typeof value is not 'string'
    continue unless typeof bookmarks[value].meta.title is 'string'
    continue if value is 'undefined'
    continue unless bookmarks[value]?.meta?.title?
    #continue unless dictWithCreatedAt[value].meta.weight > 0
    selectItem =
      label: bookmarks[value].meta.title
      value: bookmarks[value]
    options.push selectItem
  options

#FIXME does not select value when from a place
# to set value we need to know which type of select,
# which type of select we have
# needs to gurarantee there's a value, if not take it from last on user.lastTo
moS =
  bookmarks: 'links.in.Bookmarks.'
  title: 'meta.title'
setValue = (props, options) ->
  # what do we do if from isn't in bookmarks
  # what do we point to if we're not pointing to something..
  # method call connect something to save state needs T connection.
  {user, from, to, type} = props
  bookmarks = linkstate.getAllBookmarksDict user
  window.setValueState = {props,options,user} if window?
  bookmarkExistNot = !_.get bookmarks, linkstate.store(props[type])
  if bookmarkExistNot
    console.log 'unknown new place not in bookmarks'
  if !props[type] or bookmarkExistNot
    console.log bookmarkExistNot
    # because new users setupUser there should always be last actions
    userValue = user[props.type+'Last']
    BookmarkValue = linkstate.getBookmarkValue user, userValue
    label = _.get BookmarkValue, moS.title
    if BookmarkValue?
      return value =
        label: label
        value: BookmarkValue
  place = moS.bookmarks+linkstate.store(props[props.type])
  BookmarkValueProp = linkstate.getBookmarkValue props.user, props[props.type]
  label = _.get BookmarkValueProp, moS.title
  TYPE = props[props.type]
  if label? # we have it here.
    if FlowRouter? # can't run this in the unit test
      changeQueryParams props.type, props[props.type]
    return value =
      label: label
      value: BookmarkValueProp
  else
    storefrom = linkstate.store props.from
    console.log 'proplem with, should not happen'
    ,{BookmarkValueProp,label,user,props,place, TYPE}

    return value =
      label: 'picke someplace'
      value:
        meta:
          title: 'the title to pick someplace'
inBookmarks = (user, url) ->
  -> _.get user, 'links.in.' + catTree.categoryUrls.Bookmarks + linkstate.store(url)

newPlace = (user, queryParams, bookmarked) ->
  inBookmarks = _.get user, moS.bookmarks + linkstate.store(queryParams.from)
  #user?.out?.Bookmarks?[linkstate.store(queryParams.from)]
  markExists = inBookmarks?.meta?
  if bookmarked != 'true' and !markExists
    # must changeQueryParams here else it gets run multiple times
    changeQueryParams('Bookmarked', true) #sideffect
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
      if user? and user[type+'Last']?
        #queryParams[type] = user[type+'Last']
        changeQueryParams(type, user[type+'Last'])
      else
        console.log 'have not connected to anything? how is that possible?'
  user

wholeParamSaved = (paramCandidate, queryParams, client) ->
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
screenshotUrlHere = (user, from) ->
  R.prop user, 'links.in.Bookmarks'+linkstate.store(from)+'meta.ScreenshotUrl'
Gt= {}
exports.gt = Gt
exports.changeQueryParamsObject= changeQueryParamsObject
exports.changeQueryParams = changeQueryParams
exports.hereAndThere = hereAndThere
exports.setValue = setValue
exports.setOptions = setOptions
exports.newPlace = newPlace
exports.userSaved = userSaved
exports.ifBodyContentHere = ifBodyContentHere
exports.moS = moS
exports.screenshotUrlHere = screenshotUrlHere
exports.inBookmarks = inBookmarks
exports.theModel = theModel
exports.hereToThereMeta = hereToThereMeta
