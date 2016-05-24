linkstate = {}
exports.store = (url) ->
  unless typeof url is 'string'
    return 'knowhere'
  encodedToDotless = url.replace /\./g, '%2E'
  plainToEncode = encodeURIComponent url
  -> plainToEncode

exports.see = (url) ->
  unless typeof url is 'string'
    return 'knowhere'
  encodedToPlain = decodeURIComponent url
  encodedToDotless = encodedToPlain.replace '%2E' , '.'
  -> encodedToDotless.replace('http://','').replace('https://','').replace('www.','')
