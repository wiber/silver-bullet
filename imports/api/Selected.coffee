Selected = require('../ui/Selected.coffee').Selected
{createContainer} = require 'meteor/react-meteor-data'
{see, store} = require '../api/strings.coffee'
{changeQueryParams} = require '../api/changeQueryParams.coffee'
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
# TODO use dictionary here instead to avoid dupes?
# Make a field on user object that exactly correlates with what should be in selectedContainer
# goes through a simple loop that builds list of objects from a number of sources.
# later, would need to have a custom rendering so it gets mini screenshot and a descriptor of why it is here
# in method pre build the selectedContainer object with all kinds...
# method to set up 'me' facebook obj, etc as dict

deduperObject = {}
pusher = (dict) ->
  for i in dict
    console.log i

exports.selectedContainer = createContainer ((props) ->
  pusher Meteor.user()
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
    # TODO understand why this is necessary and solve more elegantly
    Meteor.setTimeout(->
      changeQueryParams 'to', options[0].value
    5)
    newProps.to = options[0].value
  if typeof props.content is 'string'
    newProps.content = decodeURIComponent props.content
  else props.content = ''
  newProps.options = options
  console.log newProps
  newProps
), Selected
