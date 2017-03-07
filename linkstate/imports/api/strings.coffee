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
