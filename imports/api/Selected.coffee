Selected = require('../ui/Selected.coffee').Selected
{createContainer} = require 'meteor/react-meteor-data'
{linkstate} = require '../api/strings.coffee'
{see} = require '../api/strings.coffee'
{store} = require '../api/strings.coffee'
exports.selectedContainer = createContainer ((props) ->
  options = [
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
  options.push
    value: do store props.from
    label: do see props.from
  console.log options
  {
    from: props.from
    to: props.to
    type: props.type
    options: options
  }
), Selected
