R = require('ramda')
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

trace = R.curry((tag, x) ->
  console.log tag, x
  x
)

linkMomentum = R.map(R.map(R.compose( R.prop 'meta' )))
exports.AByMomentum = (dictDict, many) ->
  momentum = {}
  for url of dictDict
    console.log url, dictDict[url]
    for user of dictDict[url]
      console.log user, dictDict[url][user].meta.weight
      if dictDict[url][user].meta?.weight?
        energy = dictDict[url][user].meta.weight - 5
        if typeof momentum[url] is 'number'
          momentum[url] = energy + momentum[url]
        else
          momentum[url] = energy
      if ! dictDict[url][user].meta?.weight?
        console.log energy, momentum[url]
        # how to deal with zeroes and undefined
        if typeof momentum[url] is 'undefined'
          momentum[url] = -5
        else
          momentum[url] =- 5
  toReturn = Object.keys(momentum).sort (a, b) ->
    console.log momentum,Object.keys(momentum), 'momentum'
    momentum[b] - momentum[a]
  console.log toReturn
  toReturn


exports.listByMomentum = (listOne, listTwo, many) ->
  console.log arguments[0]
  console.log listTwo

  return R.uniq(R.concat(listOne, listTwo))
