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

exports.shadowFloor = (L,floor,top) ->
  floor-Math.round(floor/Math.round(.5+L.length*(floor/top)))

exports.upMargin = ({D,d,M},weight) ->
  # between  0 and 150+400+150 margin size margin
  scalar = weight/9
  upper = D + M + M
  upm = .1*d+upper - scalar*upper
  #position = 1.3*M+d-(((weight-4)/5)*(D+M))
  #console.log 'position',weight, scalar*upper, upm, upper
  upm
exports.rightMargin = ({D,d,M},weight,n) ->
  # 150 + 200
  deg = Math.PI-Math.PI*(weight/9)
  rad = D/2
  sin = Math.sin deg
  cos = Math.cos deg
  right = d+(n*d*.66)+sin*rad-cos*rad
  #console.log 'margin', weight, deg, sin, right
  right
  rightPosition = .5*D+d+(-n*d*.66)
  if weight is 0
    rightPosition = rightPosition+D/2
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
###
