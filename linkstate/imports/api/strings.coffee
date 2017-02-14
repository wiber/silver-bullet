_ = require('ramda')
linkstate = {}
exports.store = (url) ->
  unless typeof url == 'string'
    ##console.log url,'store is encoded', url == decodeURIComponent url
    return ''
  encodedToDotless = url.replace /\./g, '%2E'
  plainToEncode = encodeURIComponent url
  -> plainToEncode

exports.see = (url) ->

  unless typeof url == 'string'
    ##console.log url,'see is encoded', url == decodeURIComponent url
    return ''
  encodedToPlain = decodeURIComponent url
  encodedToDotless = encodedToPlain.replace '%2E' , '.'
  -> encodedToDotless.replace('http://','').replace('https://','').replace('www.','')

trace = _.curry((tag, x) ->
  console.log tag, x
  x
)

exports.AByMomentum = (dictDict, many) ->
  A = _.compose _.map(trace,_.prop 'weight')
  console.log A(dictDict)
  keys = Object.keys(dictDict)
  momentum = {}
  for link of dictDict
    console.log link, dictDict[link], 'links in dictDict'

  toReturn = Object.keys(dictDict).sort (a, b) ->
    console.log dictDict, 'dictDict'
    dictDict[b].meta.weight - (dictDict[a].meta.weight)
