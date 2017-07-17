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

  P = weight-5
  G = Math.abs(P)
  scalar = Math.cos(Math.PI*G/7)
  deg = Math.PI-Math.PI*(weight/9)
  rad = D/2
  sin = Math.sin deg
  cos = Math.cos deg
  right = d+(n*d*.66)+sin*rad-cos*rad
  #console.log 'margin', weight, deg, sin, right, right
  rightPosition = .7*D+d+(-n*d*.66) - scalar*.5*D+d
  if weight is 0
    rightPosition = rightPosition+d/8
  rightPosition
exports.Position = ({measurements,weight,n,directed,axis}) ->
  # 150 + 200
  Coordinate = {}
  {D,d,M} = measurements
  P = weight-5
  G = Math.abs(P)
  scalar = Math.cos(Math.PI*G/7)
  deg = Math.PI-Math.PI*(weight/9)
  x0 = M+D/2-d/2
  if directed == 'OUTLINKS'
    direction = -1
  else
    direction = 1
  spreaderY = (we) ->
    deviation = 1-Math.sin(Math.PI*Math.abs(we)/9)/9#/15 # max 4
  spreaderX = (we) ->
    deviation = Math.sin(Math.PI*Math.abs(we)/9)/9
  for we in [0..9]
    console.log spreaderY(we)
  Coordinate.y = x0 + D*.5 * Math.cos(Math.PI * (weight/9)*spreaderY(weight))
  Coordinate.x = x0 - D*direction*.5 * Math.sin(Math.PI * weight/9) - (direction * d *.6 * n) - d*direction*spreaderX(weight)
  if weight is 0
    Coordinate.x = Coordinate.x-d/2
    Coordinate.y = Coordinate.y+d
  if 0 <= weight <= 9
    return Coordinate[axis]
  else return 0
  # wierd.. but now almost heart shaped.. stick..
###
exports.markCoordinate = ({size, weight, n}) ->
  console.log size, weight, n
  X = 200+(n*75)
  Y = size-(weight*(size/9))
  ->
    x: X
    y: Y

items = 4
i = 0
while i < items
  x = x0 + r * Math.cos(2 * Math.PI * i / items)
  y = y0 + r * Math.sin(2 * Math.PI * i / items)
  $('#center').append '<div class=\'point\' style=\'left:' + x + 'px;top:' + y + 'px\'></div>'
  i++
###
