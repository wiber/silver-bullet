# Selected.coffee
# http://localhost:3000/about?from=http%253A%252F%252Fwww.dailymail.co.uk%252Fhome%252Findex.html&lastTitle=Home%2520%257C%2520Daily%2520Mail%2520Online&content=&to=https%253A%252F%252Fen.wikipedia.org%252Fwiki%252FBiot%252C_Alpes-Maritimes
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
  # paint boxes from user objects
  # find / set value from either qp or user object.
  # sync user.toLast with qp
  # change qp, set toLast with method, redraw box optimist

  directedTo = typeof props.to is 'string' and props.to.length >

  newProps = {}
  newProps.options = []
  # make dict [type]
  # make options
  # make value
  newProps[props.type] = user[props.type+'Last']
  # much isomorphism, use db to keep string format consistency, on client, because it's just a function call
  # supply dumb component with options
  # because db has loaded user.out
  if props.user?.out?
    # TODO setup script run when user starts up handles these things
    # default data, populates select lists.. use search source?
    dictWithCreatedAt = _.extend {}
    , user.out[ linkstate.store user.services.facebook.link ] # FIXME this prevents wrongful title in dropdown but data is still written wrong here..
    , props.user.out['Jump-List'] # from db
    , props.user.out['Bookmarks']
    # how do we add Bookmarks page to the list?
    # it could be a / page with a title... from.. etc
    deChaos = linkstate.sortByKeysTime dictWithCreatedAt
    for index,value of deChaos
      if typeof value is 'string' and value != 'undefined'
        selectItem =
          label: dictWithCreatedAt[value].title #linkstate.see value # same function as use
          value: dictWithCreatedAt[value] # store whole object here
        if props[props.type] is dictWithCreatedAt[value].meta.FromLink
          newProps.value = selectItem
        newProps.options.push selectItem
    # if we still don't have a defaultValue for select
    # make it the last used type
    console.log newProps.options # was the options array well formed?
    unless newProps.value?
      newProps.value =
        label: 'Your last project was '+ user[props.type+'Last']
        value: dictWithCreatedAt[user[props.type+'Last']]
  # update queryparams unless we're fromt he same place
  if props[props.type] is not newProps[props.type]
    changeQueryParams props.type, newProps[props.type]
  props = _.extend {}, props, newProps
  #console.log props.type, user[props.type+'Last'], directedTo,'console.log user.toLast, directedTo',props
  props
), Selected
