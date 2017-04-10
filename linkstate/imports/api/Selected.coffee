# Selected.coffee
# FIXME major weakness of implementation. brittle where it should be a dumb representation of user object
# http://localhost:3000/about?from=http%253A%252F%252Fwww.dailymail.co.uk%252Fhome%252Findex.html&lastTitle=Home%2520%257C%2520Daily%2520Mail%2520Online&content=&to=https%253A%252F%252Fen.wikipedia.org%252Fwiki%252FBiot%252C_Alpes-Maritimes
# Builds the FROM and TO boxes from user object and props from queryparams
# from and to are plain decodeURIComponent urls which are then used to select defaultValue in the stateless ui component
{changeQueryParams} = require('../api/changeQueryParams.coffee')
Selected = require('../ui/Selected.coffee').Selected
{createContainer} = require 'meteor/react-meteor-data'
{see, store} = require '../api/strings.coffee'

# goes through a simple loop that builds list of objects from a number of sources.
exports.selectedContainer = createContainer ((props) ->
  # update queryparams unless we're fromt he same place

  nProps = _.extend {}, props,
    value: setValue(props,setOptions(props))
    options: setOptions(props)
  nProps
), Selected


setOptions = (props) ->
  options = []
  if props.user?.out?
    dictWithCreatedAt = props.user.out['Bookmarks']
    deChaos = linkstate.sortByKeysTime dictWithCreatedAt
    for index,value of deChaos
      if typeof value is 'string' and value != 'undefined'
        selectItem =
          label: dictWithCreatedAt[value].meta.title #linkstate.see value # same function as use
          value: dictWithCreatedAt[value] # store whole object here
        options.push selectItem
  options
setValue = (props, options) ->
  ###
  if props[props.type] is dictWithCreatedAt[value].meta.FromLink
    newProps.value = selectItem
  ###

  newProps = {}
  newProps.options = []
  value = {}
  directedTo = typeof props.to is 'string' and props.to.length > 1
  clientReady = props.user?.services?.facebook? and Meteor.isClient
  gotFrom = typeof props.from is 'string' and props.from.length > 1
  bookmarked = props.user?.out?.Bookmarks?
  dictWithCreatedAt = props.user.out['Bookmarks']
  typeValue = props[props.type]
  dictValue = dictWithCreatedAt[linkstate.store(typeValue)]
  dictValueExists = dictValue?.meta?.title?
  console.log props, options, directedTo, clientReady,gotFrom,bookmarked, typeValue, dictValue, dictValueExists
  if dictValueExists and clientReady
    value =
      label: dictValue.meta.title
      value: dictValue
  else
    value =
      label: props.lastTitle
      value:
        meta:
          FromLink: props.from
  value
###

# make value if no queryParams
# unsightly empty from while loading..
unless Meteor.user()?.services?.facebook? and Meteor.isClient
  if props.type is 'from'
    if typeof props.from is 'string' and props.from.length > 1
      console.log 'not ready, from,', props.from, props.lastTitle
      newProps.value =
        label: props.lastTitle
        value:
          meta:
            FromLink: props.from
if props.user?.out?
  dictWithCreatedAt = props.user.out['Bookmarks']
  deChaos = linkstate.sortByKeysTime dictWithCreatedAt
  for index,value of deChaos
    if typeof value is 'string' and value != 'undefined'
      selectItem =
        label: dictWithCreatedAt[value].meta.title #linkstate.see value # same function as use
        value: dictWithCreatedAt[value] # store whole object here
      if props[props.type] is dictWithCreatedAt[value].meta.FromLink
        newProps.value = selectItem
      newProps.options.push selectItem
  unless newProps.value?
    # it's not in the array, so it's not on user yet
    if props.user?[props.type+'Last']?
      if props.type is 'to'
        message = props.word.defaultProject
        newProps.value =
          label: message + props.user[props.type+'Last']
          value: dictWithCreatedAt[props.user[props.type+'Last']]
      # so one can link
      if props.type is 'from' and props[props.type]?
        newProps.value =
          label: props.lastTitle
          value:
            meta:
              FromLink: props.from

      changeQueryParams props.type, props.user[props.type+'Last']

if props[props.type] is not newProps[props.type]
  changeQueryParams props.type, newProps[props.type]
if newProps.options.length < 2
  new Meteor.Error 12, "something wrong with select options"

if props.user?.out?
  dictWithCreatedAt = props.user.out['Bookmarks']
  deChaos = linkstate.sortByKeysTime dictWithCreatedAt
  for index,value of deChaos
    if typeof value is 'string' and value != 'undefined'
      selectItem =
        label: dictWithCreatedAt[value].meta.title #linkstate.see value # same function as use
        value: dictWithCreatedAt[value] # store whole object here
      if props[props.type] is dictWithCreatedAt[value].meta.FromLink
        newProps.value = selectItem
      newProps.options.push selectItem
  unless newProps.value?
    # it's not in the array, so it's not on user yet
    if props.user?[props.type+'Last']?
      if props.type is 'to'
        message = props.word.defaultProject
        newProps.value =
          label: message + props.user[props.type+'Last']
          value: dictWithCreatedAt[props.user[props.type+'Last']]
      # so one can link
      if props.type is 'from' and props[props.type]?
        newProps.value =
          label: props.lastTitle
          value:
            meta:
              FromLink: props.from

      changeQueryParams props.type, props.user[props.type+'Last']

newProps = {}
newProps.options = []
#props.user
# paint boxes from user objects
# find / set value from either qp or user object.
# sync user.toLast with qp
# change qp, set toLast with method, redraw box optimist
#Meteor.subscribe "userData"
directedTo = typeof props.to is 'string' and props.to.length > 1
# make value if no queryParams
# unsightly empty from while loading..
unless Meteor.user()?.services?.facebook? and Meteor.isClient
  if props.type is 'from'
    if typeof props.from is 'string' and props.from.length > 1
      console.log 'not ready, from,', props.from, props.lastTitle
      newProps.value =
        label: props.lastTitle
        value:
          meta:
            FromLink: props.from
###
