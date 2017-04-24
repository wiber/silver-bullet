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
    value: setValue(props,setOptions(props),props.user)
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
        if dictWithCreatedAt[value]?.meta?.weight? and dictWithCreatedAt[value].meta.weight > 0
          selectItem =
            label: dictWithCreatedAt[value].meta.title #linkstate.see value # same function as use
            value: dictWithCreatedAt[value] # store whole object here
          options.push selectItem
        else
          console.log 'irrelevant entry', dictWithCreatedAt[value].meta.title
    # questionable ..
    ###
    for type in ['from','to']
      typeUrl = FlowRouter.getQueryParam type
      typeUrlDict = dictWithCreatedAt[linkstate.store typeUrl]
      if !typeUrlDict?.meta?
        console.log 'not already in there'
        options.push
          label: props[props.type]
          value:
            meta:
              FromLink: props[props.type]
      else
        console.log 'do nothing'
      console.log typeUrl, typeUrlDict
    ###
  options
setValue = (props, options, user) ->
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
  lastDictValue = dictWithCreatedAt[linkstate.store(user[props.type+'Last'])]
  #console.log dictValueExists, clientReady, props.to, typeValue?, typeValue.length,lastDictValue
  # what if ... you don't have a 'to' or from?  use
  # use if we don't have a to, we need to change queryParams to last to project
  if !typeValue? and lastDictValue?
    value=
      label: lastDictValue.meta.title
      value: lastDictValue
  else
    console.log 'edgeC'
  if dictValueExists and clientReady
    #console.log typeValue
    value =
      label: dictValue.meta.title
      value: dictValue
  else
    #
    value =
      label: props.lastTitle
      value:
        meta:
          FromLink: props.from
  value
