R = require('ramda')
linkstate = {}
_ = require 'lodash'
# Urlbox = require 'urlbox'

#exports.urlbox = Urlbox(Meteor.settings.public.urlboxKey, Meteor.settings.urlbox.secret)

exports.Position = ({measurements,weight,n,directed,axis}) ->
  if directed == 'OUTLINKS'
    direction = -1
    xDir = -1
  else
    direction = 1
    xDir = 1
  Coordinate = {}
  {D,d,M} = measurements
  r = D/2
  Ra = r+(.6*n+.4)*(D/d)
  center = M+r
  weightDev = (weight-5)/4 # %
  yDir =  -1*weightDev/Math.abs(weightDev)
  ty = (weightDev)*r
  x0 = M + r - .5*D/d  #D/2-.5*D/d#/2
  y0 = M + r - .5*D/d
  # angles from PI to 2*PI?
  angleO = Math.PI*(1+weightDev)/2
  speed = 15
  angle = ((n)*(.5*Math.PI*direction)+(speed*angleO))/(n+speed)
  if weight is 0
    #Coordinate.x = Coordinate.x+ d
    #Coordinate.y = Coordinate.y#+D/d
    # not entirely correct. 1 should be opposite 9 and 0 off the grid.
    angle = 0
    Coordinate.y = y0 + Ra * Math.cos(angle)-((1+n)*D/d)# + .25*D/d
    Coordinate.x = x0 - Ra *direction * Math.sin(angle)# -*D/d
  else
    Coordinate.y = y0 + Ra * Math.cos(angle)# + .25*D/d
    Coordinate.x = x0 - Ra *direction * Math.sin(angle)# -*D/d
  #asymptote = (3)/(n) @ no move angle by factor n towards straight line
  # 0 -> 1 1
  # 1 -> 1.4 , 0.8
  # 2 -> 2 , .3
  # 3 -> 3, 0
  # delta towards horizontal line. we need Coordinate for n-1?
  #Coordinate.x = Coordinate.x - (D/d) * n * .2 * (Coordinate.x/Math.abs(Coordinate.x))
  #Coordinate.y = Coordinate.y - (D/d) * n * .2 * (Coordinate.y/Math.abs(Coordinate.y))
  if 0 <= weight <= 9
    return Coordinate[axis]
  else return 0
exports.store = (url) ->
  unless typeof url == 'string'
    return ''
  encodedToDotless = url.replace /\./g, '%2E'
  plainToEncode = encodeURIComponent url
  -> plainToEncode

exports.see = (url) ->

  unless typeof url == 'string'
    return ''
  encodedToPlain = decodeURIComponent url
  encodedToDotless = encodedToPlain.replace '%2E' , '.'
  -> encodedToDotless.replace('http://','').replace('https://','').replace('www.','')

trace = R.curry((tag, x) ->
  console.log tag, x
  x
)

exports.AByMomentum = (UrlUserMeta) ->
  momentum = {}
  for url of UrlUserMeta
    for user of UrlUserMeta[url]
      if UrlUserMeta[url][user].meta?.weight?
        energy = UrlUserMeta[url][user].meta.weight - 5
        if typeof momentum[url] is 'number'
          momentum[url] = energy + momentum[url]
        else
          momentum[url] = energy
      if ! UrlUserMeta[url][user].meta?.weight?
        # how to deal with zeroes and undefined
        if typeof momentum[url] is 'undefined'
          momentum[url] = -5
        else
          momentum[url] =- 5
  toReturn = Object.keys(momentum).sort (a, b) ->
    momentum[b] - momentum[a]
  toReturn


exports.listByMomentum = (listOne, listTwo) ->
  returner = []
  for list in arguments
    if list?.length?
      returner = R.concat(returner, list)
  R.uniq returner

exports.shadowFloor = (L,floor,top) ->
  return unless L?
  floor-Math.round(floor/Math.round(.5+L.length*(floor/top)))

exports.upMargin = ({D,d,M},weight) ->
  # between  0 and 150+400+150 margin size margin
  scalar = weight/9
  upper = D + M + M
  upm = .1*d+upper - scalar*upper
  #position = 1.3*M+d-(((weight-4)/5)*(D+M))
  upm
exports.rightMargin = ({D,d,M},weight,n) ->
  # 150 + 200
  P = weight-5
  G = Math.abs(P)
  scalar = Math.cos(Math.PI*G/7)
  deg = Math.PI-Math.PI*(weight/9)
  rad = D/2
  sin = Math.sin deg
  cos = Math.cos deg
  right = d+(n*d*.66)+sin*rad-cos*rad
  rightPosition = .7*D+d+(-n*d*.66) - scalar*.5*D+d
  if weight is 0
    rightPosition = rightPosition+d/8
  rightPosition
  # wierd.. but now almost heart shaped.. stick..
###
exports.markCoordinate = ({size, weight, n}) ->
  console.log size, weight, n
  X = 200+(n*75)
  Y = size-(weight*(size/9))
  ->
    x: X
    y: Y

items = 4
i = 0
while i < items
  x = x0 + r * Math.cos(2 * Math.PI * i / items)
  y = y0 + r * Math.sin(2 * Math.PI * i / items)
  $('#center').append '<div class=\'point\' style=\'left:' + x + 'px;top:' + y + 'px\'></div>'
  i++
###
linkstate = {}
linkstate.sortByKeys = (dict, many) ->
  toReturn = Object.keys(dict).sort (a, b) ->
    dict[b] - (dict[a])
  toReturn[..many]

linkstate.sortByKeysTime = (dict, many) ->

  if !dict
    console.log 'dict is nothing!',dict
    return {}
  #console.log typeof(Object.keys(dict)),{dict},Object.keys(dict)
  if typeof(Object.keys(dict)) is not "object"
    return {}
  toReturn = Object.keys(dict).sort (a, b) ->
    dict[b].createdAt - (dict[a].createdAt)
  toReturn[..many]

linkstate.sortByWeight = (dict, many) ->
  return unless dict?
  return unless Object.keys(dict).length > 0
  toReturn = Object.keys(dict).sort (a, b) ->
    dict[b].meta.weight - (dict[a].meta.weight)
  toReturn[..many]

linkstate.sortByMomentum = (dictDict, many) ->
  keys = Object.keys(dictDict)
  momentum = {}
  toReturn = Object.keys(dictDict).sort (a, b) ->
    dictDict[b].meta.weight - (dictDict[a].meta.weight)

linkstate.thumbalizrPic = (url) ->
  newUrl = "https://api.thumbalizr.com/?url="+url+"&width=250&api_key="+Meteor.settings.public.thumbalizr
  return newUrl

dot = '%2E'
ddot = '%25252E'
linkstate.unddot = (url) ->
  url.replace ddot, '.'
linkstate.store = (url) ->
  unless typeof url is 'string' or url is not 'undefined'
    return null
  plainToEncode = encodeURIComponent url
  encodedToDotless = plainToEncode.replace /\./g, dot
  return encodedToDotless

linkstate.see = (url) ->
  unless typeof url == 'string'
    return null
  encodedToPlain = decodeURIComponent url
  encodedToDotless = encodedToPlain.replace dot, '.'
  encodedToDotless.replace('http://','').replace('https://','').replace('www.','')


linkstate.storageEncode = (url) ->
  r =  toString(url).replace /\./g , '%2E'
  return r
linkstate.nodeParam = (url) ->
  check stringed, String
  encoded = encodeURIComponent(url)
  return "/node/?&url="+encoded

linkstate.urlName = (stringed) ->
  check stringed, String
  stringed.replace /\.(.*)/g, ''

linkstate.toDotless = (stringed) ->
  check stringed, String
  stringed.replace /\./g, '%2E'

linkstate.fromDotless = (stringed) ->
  #check stringed, String
  stringed.replace /%2E/g, '.'
linkstate.noProtocoll = (stringed) ->
  check stringed, String
  stringed.replace('http://','').replace('https://','').replace('www.','')
#@linkstate = linkstate
exports.changeQueryParams = (key,value) ->
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

exports.changeQueryParamsObject = (changes) ->
  #changeFunc = (value,key, obj) ->
  #  exports.changeQueryParams key, value
  #R.mapObjIndexed changeFunc, changes
  for key, value of changes
    exports.changeQueryParams key, value

categoryTypes = [
  'Bookmarks'
  'Categories'
]
bookmarkUrl = 'en.wikipedia.org/wiki/bookmark'
linkstate.constants =
  bookmarkUrl: bookmarkUrl
linkstate.categoryTypes = categoryTypes
linkstate.catTree =
  categoryTypes: categoryTypes
  categoryUrls:
    Bookmarks: bookmarkUrl
    Services: "https://en.wikipedia.org/wiki/Identity_provider"
  ModelNamespaces:
    Bookmarks: 'links.in.'+linkstate.store(bookmarkUrl)
BookmarkPath = 'links.in.'+linkstate.store(linkstate.catTree.categoryUrls.Bookmarks)

linkstate.getBookmarkValue = (user, plainUrl) ->
  dotlessUrl = linkstate.store plainUrl
  path = 'links.in.'+linkstate.catTree.categoryUrls.Bookmarks+'.'+plainUrl
  #console.log path
  BookmarkValue = _.get user, 'links.in.'+linkstate.store(linkstate.catTree.categoryUrls.Bookmarks)+'.'+dotlessUrl
  if !BookmarkValue
    #.in # broke the whole app on new user
    console.log {plainUrl}, 'exist not in', user.links,_.get user, 'links.in'
  BookmarkValue
# why isn't the call updating the bookmark list? we need a specialised layer talking to an api?
linkstate.getAllBookmarksDict = (user) ->
  bookmarkDict = _.get user, BookmarkPath
  #console.log {bookmarkDict}
  bookmarkDict
# what do we do if the 'here' bookmark doesn't exist in the dict - it should!
linkstate.getTheBookmark = (user, target) ->
  try
    bookmarkDict = linkstate.getAllBookmarksDict(user)
    theBookmark = R.prop linkstate.store(target), bookmarkDict
    return theBookmark
  catch err
    return ""
linkstate.bookmarkExistHere = (user, target) ->
  bookDict = linkstate.getAllBookmarksDict(user)
  storeTarget = linkstate.store(target)
  unless !linkstate.getAllBookmarksDict(user)
    return linkstate.store(target) of linkstate.getAllBookmarksDict(user)
  else
    return false

linkstate.getTheScreenshot = (node) ->
  #console.log node
  #console.log R.prop 'meta.ScreenshotUrl', node
  #theScreenshot =  R.prop 'meta.ScreenshotUrl', node
  #theScreenshot
  unless !node
    return R.prop 'meta.ScreenshotUrl', node

linkstate.mustPointSomewhere = (user ) ->

linkstate.lastTabHighlightedObjectify = (queryParams) ->
  updater = {}
  try
    lastTabHighlighted = JSON.parse(decodeURIComponent queryParams.lastTabHighlighted)
    if !!lastTabHighlighted
      for tabStep in lastTabHighlighted
        updater[tabStep.url] =
          from: tabStep.url
          ScreenshotUrl: urlbox.buildUrl
            url: tabStep.url
          createdAt: tabStep.createdAt

  catch error
    console.log error,'uri bad', queryParams



#linkstate = {} if !linkstate?

exports.linkstate = linkstate
