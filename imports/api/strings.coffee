linkstate = {}
exports.store = (url) ->
  #console.log 'store is encoded', url == decodeURIComponent url
  unless typeof url == 'string'
    return null
  encodedToDotless = url.replace /\./g, '%2E'
  plainToEncode = encodeURIComponent url
  -> plainToEncode

exports.see = (url) ->
  #console.log 'see is encoded', url == decodeURIComponent url
  unless typeof url == 'string'
    return null
  encodedToPlain = decodeURIComponent url
  encodedToDotless = encodedToPlain.replace '%2E' , '.'
  -> encodedToDotless.replace('http://','').replace('https://','').replace('www.','')
