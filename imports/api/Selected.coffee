# Selected.coffee
# Builds the FROM and TO boxes from user object and props from queryparams
# from and to are plain decodeURIComponent urls which are then used to select defaultValue in the stateless ui component

Selected = require('../ui/Selected.coffee').Selected
{createContainer} = require 'meteor/react-meteor-data'
{see, store} = require '../api/strings.coffee'
{changeQueryParams} = require '../api/changeQueryParams.coffee'

# goes through a simple loop that builds list of objects from a number of sources.


exports.selectedContainer = createContainer ((props) ->

  newProps = {}
  newProps.options = []

  # much isomorphism, use db to keep string format consistency, on client, because it's just a function call
  if Meteor.userId()? and Meteor.user().out? # supply dumb component with options
    ##console.log linkstate.sortByKeysTime(Meteor.user().out['Jump-List'])[0]
    dictWithCreatedAt = _.extend {}
    , Meteor.user().out['Jump-List'] # from db
    , Meteor.user().in['Jump-List']
    deChaos = linkstate.sortByKeysTime dictWithCreatedAt
    ##console.log deChaos, Meteor.user().out, Meteor.user().out['Jump-List']
    for index,value of deChaos
      if typeof value is 'string' and value != 'undefined'
        newProps.options.push
          label: linkstate.see value # same function as use
          value: dictWithCreatedAt[value] # store whole object here
  if Meteor.userId()? and Meteor.user().to?
    toPossibles = linkstate.sortByKeysTime(Meteor.user().to,5)
    #console.log toPossibles, 'toPossibles',props.to, Meteor.user().to[toPossibles[1]]
    newProps.to = Meteor.user().to[toPossibles[1]]
  props = _.extend {}, props, newProps
  if props.type is 'to'
    console.log props.to, props, newProps
  props
), Selected
