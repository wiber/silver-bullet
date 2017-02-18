# only use these for cascading style for _.extent {}, style.base, style.card ...
scalars =
  fontScale: -> 1
  goldenRatio: -> ((1 + Math.sqrt(5)) / 2)
  screenshotWidth: 250

style =
  scalars: scalars
  base:
    #background: 'rgba(54, 99, 25, 0.05)'
    height: '100%'
    width: '100%'
  overlayPercentage:
    maxHeight: 200
    overflow: 'hidden'
  card:
    background: 'rgba(255, 255, 255, 0.8)'
    margin: '2em'
    padding: '1em'
    maxWidth: 640
  mCard:
    background: 'rgba(255, 255, 255, .9)'
    marginTop: '15%'
  webShot:
    opacity: 1
    width: '100%'
  fromBullet:
    width: '100%'
    height: '100%'
    borderRadius: '0 70% 70% 0'
    border: '1px solid blue'
    backgroundColor: 'white'
    position: 'absolute'
    marginLeft: '-30%'
    top: 0
    zIndex: 0
    overflow: 'hidden'
  yCard:
    background: 'rgba(255, 255, 255, .9)'
  aCard:
    background: 'rgba(255, 255, 255, .9)'
  h1:
    fontSize: Math.pow(scalars.goldenRatio(),2) * scalars.fontScale() + 'em'
  h2:
    fontSize: scalars.goldenRatio() * scalars.fontScale() + 'em'
exports.style = style
