linkstate = {}
{check} = require('meteor/check')
exports.store = (url) ->
  encodedToDotless = url.replace /\./g, '%2E'
  plainToEncode = encodeURIComponent url
  console.log plainToEncode
  , ' plainToEncode'
  -> plainToEncode

exports.see = (url) ->
  encodedToPlain = decodeURIComponent url
  encodedToDotless = encodedToPlain.replace '%2E' , '.'
  console.log encodedToDotless, 'encodedToDotless'
  -> encodedToDotless
#toggles between storage safe strings and plain urls
linkstate.urlT = (url) ->
  unless typeof url is 'string'
    console.log url, 'is not a string'
    -> 'knowhere'
  else
    checker = (str) ->
      dot: str.search('\.')  != -1
      slash: str.search('/')  != -1
      tDot: str.search('\uff0E')  != -1
      enc: str.search('%3F') != -1
    check = checker(url)
    console.log check.dot, check.slash, check.tDot, check.enc, "dot, slash, tDot, enc, "#, url
    newstring = url
    if check.dot and check.slash

      encodedToDotless = url.replace /\./g , '%2E'
      plainToEncode = encodeURIComponent url
      console.log url
      , 'plain url so storage safe it'
      , encodedToDotless
      -> encodedToDotless
    if check.enc and check.tDot and !check.dot
      console.log url
      , "it's already storage safe so toggle it"
      encodedToPlain = decodeURIComponent url
      encodedToDotless = encodedToPlain.split('.').join('\uff0E')
      console.log encodedToDotless, 'encodedToDotless'
      -> encodedToDotless


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

exports.linkstate = linkstate
