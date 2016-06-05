Selected = require('../ui/Selected.coffee').Selected
{createContainer} = require 'meteor/react-meteor-data'
{see, store} = require '../api/strings.coffee'

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
      value: 'therethere'
      label: 'ThereThereThereThereThereThereThereThereThereThereThereThere'
    }
  ]
  options.push
    value: do store props.from
    label: do see props.from
  {
    from: do store props.from
    to: do store props.to
    type: props.type
    options: options
  }
), Selected
