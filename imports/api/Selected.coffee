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
  newProps = {}
  newProps.options = []
  #props.user
  # paint boxes from user objects
  # find / set value from either qp or user object.
  # sync user.toLast with qp
  # change qp, set toLast with method, redraw box optimist
  Meteor.subscribe "userData"
  user = Meteor.user()

  directedTo = typeof props.to is 'string' and props.to.length >
  # make value
  if !props[props.type]? and user?[props.type+'Last']?
    newProps[props.type] = user[props.type+'Last']
  if props.user?.out?
    dictWithCreatedAt = props.user.out['Bookmarks']
    deChaos = linkstate.sortByKeysTime dictWithCreatedAt
    console.log deChaos, dictWithCreatedAt,'console.log deChaos, dictWithCreatedAt'
    for index,value of deChaos
      if typeof value is 'string' and value != 'undefined'
        selectItem =
          label: dictWithCreatedAt[value].title #linkstate.see value # same function as use
          value: dictWithCreatedAt[value] # store whole object here
        if props[props.type] is dictWithCreatedAt[value].meta.FromLink
          newProps.value = selectItem
        newProps.options.push selectItem
   #console.log newProps.options # was the options array well formed?
    unless newProps.value?
      if user[props.type+'Last']?
        newProps.value =
          label: 'Your last project was '+ user[props.type+'Last']
          value: dictWithCreatedAt[user[props.type+'Last']]
      else
        newProps.value =
          label: 'Your last project was your Bookmarks'#+ user[props.type+'Last']
          value: deChaos['Bookmarks']# dictWithCreatedAt[user[props.type+'Last']]
  # update queryparams unless we're fromt he same place
  if props[props.type] is not newProps[props.type]
    changeQueryParams props.type, newProps[props.type]
  if newProps.options.length < 2
    console.log newProps.options.length, newProps, user
    new Meteor.Error 12, "something wrong with select options"
  props = _.extend {}, props, newProps
  props
), Selected
