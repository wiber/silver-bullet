
exports.style =
  base:
    background: 'rgba(54, 99, 25, .05)'
    height: '100%'
    width: '100%'
    margin: '2em'
  card:
    background: 'rgba(54, 25, 25, .05)'
    height: 'auto'
    margin: '1em'
  mCard: Object.assign {} , @card,
    background: 'rgba(54, 25, 100, .1)'
  yCard: _.extend {} , @mCard,
    background: 'rgba(54, 100, 25, .1)'
