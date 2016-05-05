Selected = require('./Selected.coffee').Selected
ReactDOM = require('react-dom')
{createContainer} = require 'meteor/react-meteor-data'

selectedContainer = createContainer ((props) ->
  {
    from: props.from
    to: props.to
    type: props.type
    options: [
      {
        value: 'here'
        label: 'Here'
      }
      {
        value: 'there'
        label: 'There'
      }
      {
        value: 'therethere  '
        label: 'ThereThereThereThereThereThereThereThereThereThereThereThere'
      }
    ]
  }
), Selected

exports.selectedContainer = selectedContainer
