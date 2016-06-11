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
  console.log typeof Meteor.user().when
  options = []
  ###  [{
      value: 'therethere'
      label: 'ThereThereThereThereThereThereThereThereThereThereThereThere'
    }
  ]###
  try # to combine data structures into one dropdown
    fromWhere = {}
    fromWhere[props[props.type]] =
      createdAt: new Date().getTime()
    deChaos = linkstate.sortByKeysTime(_.extend {}, Meteor.user().out, Meteor.user().in, fromWhere)
    console.log fromWhere, deChaos
  catch error


  arrayFromDict = (D) ->
    console.log typeof D is 'object'
    if typeof D is 'object'
      console.log D, linkstate.sortByKeysTime(D)
      for index,key of linkstate.sortByKeysTime(D)
        options.push
          value: key
          label: do see key
  arrayFromDict(Meteor.user().in)
  ###if typeof Meteor.user().when == 'object'
    dropList = linkstate.sortByKeysTime Meteor.user().when
    for i in dropList
      console.log i
      options.push
        value: do store i
        label: do see i###
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
  newProps.options = _.uniq options
  console.log newProps, options
  newProps
), Selected
