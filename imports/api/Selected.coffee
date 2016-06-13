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
  from = typeof props.from is 'string'
  to =  typeof props.to is 'string'
  newProps = {}
  newProps.options = []
  # much isomorphism, use db to keep string format consistency, on client, because it's just a function call
  if typeof Meteor.user().out is 'object' # supply dumb component with options
    #console.log linkstate.sortByKeysTime(Meteor.user().out['Jump-List'])[0]
    deChaos = linkstate.sortByKeysTime _.extend {}
    , Meteor.user().out # from db
    , Meteor.user().in
    for index,value of deChaos
      if typeof value is 'string'
        newProps.options.push
          label: linkstate.see value
          value: value # from db so don't double encode for storage
  if typeof Meteor.user().out is 'object'
    newProps.to = linkstate.sortByKeysTime(Meteor.user().out,5)[0]
  newProps
), Selected
