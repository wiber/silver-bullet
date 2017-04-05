# these are convenience functions for handling strings
linkstate = {}
linkstate.sortByKeys = (dict, many) ->
  toReturn = Object.keys(dict).sort (a, b) ->
    dict[b] - (dict[a])
  toReturn[..many]

linkstate.sortByKeysTime = (dict, many) ->
  toReturn = Object.keys(dict).sort (a, b) ->
    dict[b].createdAt - (dict[a].createdAt)
  toReturn[..many]

linkstate.sortByWeight = (dict, many) ->
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
linkstate.store = (url) ->
  unless typeof url is 'string' or url is not 'undefined'
    return null
  plainToEncode = encodeURIComponent url
  encodedToDotless = plainToEncode.replace /\./g, '%2E'
  encodedToDotless

linkstate.see = (url) ->
  unless typeof url == 'string'
    return null
  encodedToPlain = decodeURIComponent url
  encodedToDotless = encodedToPlain.replace '%2E' , '.'
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
  check stringed, String
  stringed.replace /%2E/g, '.'
linkstate.noProtocoll = (stringed) ->
  check stringed, String
  stringed.replace('http://','').replace('https://','').replace('www.','')
@linkstate = linkstate
