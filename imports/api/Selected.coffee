# Selected.coffee
# Builds the FROM and TO boxes from user object and props from queryparams
# from and to are plain decodeURIComponent urls which are then used to select defaultValue in the stateless ui component
{changeQueryParams} = require('../api/changeQueryParams.coffee')
Selected = require('../ui/Selected.coffee').Selected
{createContainer} = require 'meteor/react-meteor-data'
{see, store} = require '../api/strings.coffee'
{changeQueryParams} = require '../api/changeQueryParams.coffee'

# goes through a simple loop that builds list of objects from a number of sources.


exports.selectedContainer = createContainer ((props) ->
  newProps = {}
  newProps.options = []
  user = Meteor.user()
  # much isomorphism, use db to keep string format consistency, on client, because it's just a function call
  if Meteor.userId()? and Meteor.user().out? # supply dumb component with options
    dictWithCreatedAt = _.extend {}
    , Meteor.user().out['Jump-List'] # from db
    , Meteor.user().out['Yours-Truly']
    deChaos = linkstate.sortByKeysTime dictWithCreatedAt
    for index,value of deChaos
      if typeof value is 'string' and value != 'undefined'
        newProps.options.push
          label: linkstate.see value # same function as use
          value: dictWithCreatedAt[value] # store whole object here
  if Meteor.userId()? and Meteor.user().to? and props.to is 'undefined'
    toPossibles = linkstate.sortByKeysTime(Meteor.user().to,5)
    #http://stackoverflow.com/questions/2631001/javascript-test-for-existence-of-nested-object-key
    toPossibles = linkstate.sortByKeysTime(Meteor.user().to,5)
    try
      newProps.to = Meteor.user().to[toPossibles[1]].meta.FromLink
      changeQueryParams 'to', newProps.to
    catch error
      console.log error, 'does local user object exist yet?'
  props = _.extend {}, props, newProps
  if props.type is 'to'
    console.log props.to, props, newProps
  console.log Nodes.find().count(), 'subscribe 2', Nodes.find().fetch()
  # if we are from a new place, link it to Yours-Truly
  # fill form from db object


  props
), Selected
