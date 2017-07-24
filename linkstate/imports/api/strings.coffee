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
  if directed == 'OUTLINKS'
    direction = -1
    xDir = -1
  else
    direction = 1
    xDir = 1
  Coordinate = {}
  {D,d,M} = measurements
  r = D/2
  Ra = r+(.6*n+.4)*(D/d)
  center = M+r
  weightDev = (weight-5)/4 # %
  yDir =  -1*weightDev/Math.abs(weightDev)
  ty = (weightDev)*r
  x0 = M + r - .5*D/d  #D/2-.5*D/d#/2
  y0 = M + r - .5*D/d
  # angles from PI to 2*PI?
  angleO = Math.PI*(1+weightDev)/2
  speed = 15
  angle = ((n)*(.5*Math.PI*direction)+(speed*angleO))/(n+speed)
  if weight is 0
    #Coordinate.x = Coordinate.x+ d
    #Coordinate.y = Coordinate.y#+D/d
    # not entirely correct. 1 should be opposite 9 and 0 off the grid.
    angle = 0
    Coordinate.y = y0 + Ra * Math.cos(angle)-((1+n)*D/d)# + .25*D/d
    Coordinate.x = x0 - Ra *direction * Math.sin(angle)# -*D/d
  else
    Coordinate.y = y0 + Ra * Math.cos(angle)# + .25*D/d
    Coordinate.x = x0 - Ra *direction * Math.sin(angle)# -*D/d
  #asymptote = (3)/(n) @ no move angle by factor n towards straight line
  # 0 -> 1 1
  # 1 -> 1.4 , 0.8
  # 2 -> 2 , .3
  # 3 -> 3, 0
  # delta towards horizontal line. we need Coordinate for n-1?
  #Coordinate.x = Coordinate.x - (D/d) * n * .2 * (Coordinate.x/Math.abs(Coordinate.x))
  #Coordinate.y = Coordinate.y - (D/d) * n * .2 * (Coordinate.y/Math.abs(Coordinate.y))
  if 0 <= weight <= 9
    return Coordinate[axis]
  else return 0
