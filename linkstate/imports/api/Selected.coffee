# Selected.coffee
# FIXME major weakness of implementation.
# brittle where it should be a dumb representation of user object
# Builds the FROM and TO boxes from user object and props from queryparams
# from and to are plain decodeURIComponent urls
# which are then used to select defaultValue in the stateless ui component
# {changeQueryParams} = require('../api/changeQueryParams.coffee')
Selected = require('../ui/SelectedUI.coffee').Selected
{createContainer} = require 'meteor/react-meteor-data'
# {linkstate, see, store} = require '../api/strings.coffee'
{setOptions, setValue} = require '../api/ModelOperations'
# goes through a simple loop
#that builds list of objects from a number of sources.
exports.selectedContainer = createContainer ((props) ->
  # update queryparams unless we're fromt he same place
  window.selectedProps = props
  nProps = _.extend {}, props,
    value: setValue(props,setOptions(props),props.user)
    options: setOptions(props)
  #console.log nProps.value, typeof linkstate.store
  console.log 'lowerc',nProps.options
  nProps
), Selected
###
oDict = {}
vDict = {}
setOptions = (props) ->
  options = []
  if props.user?.links?.out?
    # how titles get into selectize
    dictWithCreatedAt = props.user.links.in['Bookmarks']
    oDict = dictWithCreatedAt
    deChaos = linkstate.sortByKeysTime dictWithCreatedAt
    for index, value of deChaos
      continue if typeof value is not 'string'
      continue if value is 'undefined'
      continue unless dictWithCreatedAt[value]?.meta?.title?
      #continue unless dictWithCreatedAt[value].meta.weight > 0
      selectItem =
        label: dictWithCreatedAt[value].meta.title
        value: dictWithCreatedAt[value]
      options.push selectItem
  options

#FIXME does not select value when from a place
setValue = (props, options, user) ->
  newProps = {}
  newProps.options = []
  value = {}
  return unless props.user?.links?.in?['Bookmarks']?
  directedTo = typeof props.to is 'string' and props.to.length > 1
  clientReady = props.user?.services?.facebook? and Meteor.isClient
  gotFrom = typeof props.from is 'string' and props.from.length > 1
  bookmarked = props.user?.links?.in?.Bookmarks?
  dictWithCreatedAt = props.user.links.in['Bookmarks']
  vDict = dictWithCreatedAt
  typeValue = props[props.type]
  dictValue = dictWithCreatedAt[linkstate.store(typeValue)]
  dictValueExists = dictValue?.meta?.title?
  lastDictValue = dictWithCreatedAt[linkstate.store(user[props.type+'Last'])]
  setLastTitle = true if props.newHere
  # if we're in a new place, we want to point to the last place we connected to
  # do we simply walk backwards untill we find a place not here?
  # the problem is pointing to.. we are getting the wrong to value
  # make negative cases...
  if !typeValue? and lastDictValue?
    value=
      label: lastDictValue.meta.title
      value: lastDictValue
  if props.type is 'from'
    if dictValueExists
      title = 'Linkstates for ' + dictValue.title + ' - ' + props.from
      DocHead.setTitle(title) # needs attention
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
          title: props.lastTitle

  value
###
