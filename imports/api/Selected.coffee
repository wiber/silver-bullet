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
  # much isomorphism, use db to keep string format consistency, on client, because it's just a function call
  if props.user?.out? # supply dumb component with options
    dictWithCreatedAt = _.extend {}
    , props.user.out['Jump-List'] # from db
    , props.user.out['Yours-Truly']
    deChaos = linkstate.sortByKeysTime dictWithCreatedAt
    for index,value of deChaos
      if typeof value is 'string' and value != 'undefined'
        newProps.options.push
          label: linkstate.see value # same function as use
          value: dictWithCreatedAt[value] # store whole object here
  unless props.to? and props.to.length > 5
    console.log 'no to'
    if props.user?.to?
      console.log 'got user to'
      toPossibles = linkstate.sortByKeysTime(Meteor.user().to,5)
  decideDirection = () ->
    toReturn = ''
    if props.user?.lastTo and !props.to
      toReturn = props.user?.lastTo
    unless typeof props.to is 'string'
      console.log 'no to prop', props.to
      if props.user?.to?
        console.log 'got user to prop'
        toPossibles = linkstate.sortByKeysTime(Meteor.user().to,5)
        ifOnlyOne = 0
        if toPossibles.length > 1
            ifOnlyOne = 1
        try
          #console.log ifOnlyOne,Meteor.user().to[toPossibles[ifOnlyOne]], 'Meteor.user().to[toPossibles[ifOnlyOne]]'
          toReturn = props.user.to[toPossibles[ifOnlyOne]].meta.FromLink
          changeQueryParams 'to', toReturn
        catch error
          console.log error, 'does local user object exist yet?'
          toReturn =  ''
    toReturn
  newProps.to = decideDirection()
  props = _.extend {}, props, newProps
  console.log props.from, props.to, typeof props.to, 'props should have from and to'
  props
), Selected
