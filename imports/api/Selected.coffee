# Selected.coffee
# Builds the FROM and TO boxes from user object


Selected = require('../ui/Selected.coffee').Selected
{createContainer} = require 'meteor/react-meteor-data'
{see, store} = require '../api/strings.coffee'
{changeQueryParams} = require '../api/changeQueryParams.coffee'

# TODO use dictionary here instead to avoid dupes?
# Make a field on user object that exactly correlates with what should be in selectedContainer
# goes through a simple loop that builds list of objects from a number of sources.
# later, would need to have a custom rendering so it gets mini screenshot and a descriptor of why it is here
# in method pre build the selectedContainer object with all kinds...
# method to set up 'me' facebook obj, etc as dict

deduperObject = {}
# build the array from the user object in and out ..

# Meteor.user().in
# has a dict like this
# FROM:
exports.selectedContainer = createContainer ((props) ->
  options = []
  fromWhere = {}
  fromProp = {}
  toProp = {}
  timeNow =
    createdAt: new Date().getTime()
  if typeof props.to is 'string'
    toProp[decodeURIComponent props.to] = timeNow

  if typeof props.from is 'string'
    fromProp[decodeURIComponent props.from] = timeNow

  console.log _.extend {}
  , Meteor.user().out
  , Meteor.user().in
  , toProp
  , fromProp
  deChaos = linkstate.sortByKeysTime _.extend {}
  , Meteor.user().out
  , Meteor.user().in
  , toProp
  , fromProp
  for index,value of deChaos
    if typeof value is 'string'
      options.push
        label: do see value
        value: do store value

  console.log deChaos
  newProps = {}
  if typeof props.from is 'string'
    newProps.from = do store props.from
  else
    newProps.from = options[0].value
  if typeof props.to is 'string'
    newProps.to = do store props.to
  else
    # TODO understand why this is necessary and solve more elegantly
    try
      Meteor.setTimeout(->
        changeQueryParams 'to', options[0].value
      5)
      newProps.to = options[0].value
    catch error
  if typeof props.content is 'string'
    newProps.content = decodeURIComponent props.content
  else props.content = ''
  newProps.options = options
  console.log newProps, options
  newProps
), Selected
