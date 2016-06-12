# these are convenience functions for handling strings
linkstate = {}
linkstate.sortByKeys = (dict, many) ->
  toReturn = Object.keys(dict).sort (a, b) ->
    dict[b] - (dict[a])
  toReturn[..many]

linkstate.sortByKeysTime = (dict, many) ->
  toReturn = Object.keys(dict).sort (a, b) ->
    dict[b].createdAt - (dict[a].createdAt)
  #console.log toReturn.length, _.uniq(toReturn).length
  toReturn[..many]
###
linkstate.store = (url) ->
  unless typeof url == 'string'
    console.log url,'store is encoded', url == decodeURIComponent url
    return ''
  encodedToDotless = url.replace /\./g, '%2E'
  plainToEncode = encodeURIComponent url
  -> plainToEncode

linkstate.see = (url) ->
  unless typeof url == 'string'
    console.log url,'see is encoded', url == decodeURIComponent url
    return ''
  encodedToPlain = decodeURIComponent url
  encodedToDotless = encodedToPlain.replace '%2E' , '.'
  -> encodedToDotless.replace('http://','').replace('https://','').replace('www.','')

###
linkstate.store = (url) ->
  #console.log 'store is encoded', url == decodeURIComponent url
  unless typeof url == 'string'
    return null
  plainToEncode = encodeURIComponent url
  encodedToDotless = plainToEncode.replace /\./g, '%2E'
  encodedToDotless

linkstate.see = (url) ->
  #console.log 'see is encoded', url == decodeURIComponent url
  unless typeof url == 'string'
    return null
  encodedToPlain = decodeURIComponent url
  encodedToDotless = encodedToPlain.replace '%2E' , '.'
  encodedToDotless.replace('http://','').replace('https://','').replace('www.','')


linkstate.storageEncode = (url) ->
  #r = encodeURIComponent url
  r =  toString(url).replace /\./g , '%2E'
  #console.log r
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
