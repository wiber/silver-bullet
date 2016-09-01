# only use these for cascading style for _.extent {}, style.base, style.card ...
scalars =
  fontScale: -> 1
  goldenRatio: -> ((1 + Math.sqrt(5)) / 2)
  screenshotWidth: 250

exports.style =
  base:
    background: 'rgba(54, 99, 25, .05)'
    height: '100%'
    width: '100%'
  card:
    background: 'rgba(255, 255, 255, .5)'
    margin: '2em'
    padding: '1em'
  overlayPercentage:
    maxHeight: 200
    overflow: 'hidden'
  mCard:
    background: 'rgba(255, 255, 255, .5)'
  webShot:
    opacity: .9
  yCard:
    background: 'rgba(255, 255, 255, .5)'
  aCard:
    background: 'rgba(255, 255, 255, .5)'
  h1:
    fontSize: Math.pow(scalars.goldenRatio(),2) * scalars.fontScale() + 'em'
  h2:
    fontSize: scalars.goldenRatio() * scalars.fontScale() + 'em'
