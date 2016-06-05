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
  newProps = {}
  if typeof props.from is 'string'
    newProps.from = do store props.from
  else
    newProps.from = options[0].value
  if typeof props.to is 'string'
    newProps.to = do store props.to
  else
    newProps.to = options[0].value
  if typeof props.content is 'string'
    newProps.content = decodeURIComponent props.content
  else props.content = ''
  newProps.options = options
  newProps
), Selected
