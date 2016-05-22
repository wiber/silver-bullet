# only use these for cascading style for _.extent {}, style.base, style.card ...
scalars =
  fontScale: -> 1
  goldenRatio: -> ((1 + Math.sqrt(5)) / 2)

exports.style =
  base:
    background: 'rgba(54, 99, 25, .05)'
    height: '100%'
    width: '100%'
  card:
    background: 'rgba(54, 25, 25, .05)'
    margin: '2em'
    padding: '1em'
  mCard:
    background: 'rgba(199, 25, 25, .05)'
  yCard:
    background: 'rgba(54, 25, 199, .05)'
  aCard:
    background: 'rgba(54, 125, 25, .05)'
  h1:
    fontSize: Math.pow(scalars.goldenRatio(),2) * scalars.fontScale() + 'em'
  h2:
    fontSize: scalars.goldenRatio() * scalars.fontScale() + 'em'
