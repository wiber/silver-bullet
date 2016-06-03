

linkstate = {}

linkstate.store = (url) ->
  console.log 'store is encoded', url == decodeURIComponent url
  unless typeof url == 'string'
    return null
  encodedToDotless = url.replace /\./g, '%2E'
  plainToEncode = encodeURIComponent url
  -> plainToEncode

linkstate.see = (url) ->
  console.log 'see is encoded', url == decodeURIComponent url
  unless typeof url == 'string'
    return null
  encodedToPlain = decodeURIComponent url
  encodedToDotless = encodedToPlain.replace '%2E' , '.'
  -> encodedToDotless.replace('http://','').replace('https://','').replace('www.','')


linkstate.storageEncode = (url) ->
  #r = encodeURIComponent url
  r =  toString(url).replace /\./g , '%2E'
  console.log r
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