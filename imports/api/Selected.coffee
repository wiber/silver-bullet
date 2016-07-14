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
  user = props.user
  directedTo = typeof props.to is 'string' and props.to.length > 5
  console.log user.lastTo, directedTo,'console.log user.lastTo, directedTo'
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
  if props.user?.to? and props.to is 'undefined'
    toPossibles = linkstate.sortByKeysTime(props.user.to,5)
    #http://stackoverflow.com/questions/2631001/javascript-test-for-existence-of-nested-object-key
    toPossibles = linkstate.sortByKeysTime(props.user.to,5)
    # otherwise it's always your last landed on one
    if toPossibles.length > 1
      ifOnlyOne = 1
    else
      ifOnlyOne = 0
    try
      #console.log ifOnlyOne,props.user.to[toPossibles[ifOnlyOne]], 'props.user.to[toPossibles[ifOnlyOne]]'
      newProps.to = props.user.to[toPossibles[ifOnlyOne]].meta.FromLink
      changeQueryParams 'to', newProps.to
    catch error
      console.log error, 'does local user object exist yet?'
  props = _.extend {}, props, newProps
  props
), Selected
