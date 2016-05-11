
styles =
  base:
    background: 'rgba(54, 99, 25, .1)'
    height: '100%'
    width: '100%'
    margin: '2em'
  card:
    background: 'rgba(54, 25, 25, .1)'
    height: 'auto'
    margin: '1em'
combines =
  mainCard:
    background: 'rgba(54, 25, 25, .6)'
    height: 'auto'
    margin: '1em'
exports.style = _.extend styles, combines
