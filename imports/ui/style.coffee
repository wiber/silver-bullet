
styles =
  base:
    background: 'rgba(54, 99, 25, 0)'
  card:
    background: 'rgba(54, 25, 25, .1)'
    height: 'auto'
    margin: '1em'
  mainCard:
    background: 'rgba(54, 25, 25, .5)'
    height: '999'

exports.style =
  base:
    background: 'rgba(54, 99, 25, 0)'
  card:
    background: 'rgba(54, 25, 25, .1)'
    height: 'auto'
    margin: '1em'
  mainCard: _.extend styles.base, styles.mainCard
