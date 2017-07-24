# Selected.coffee
# FIXME major weakness of implementation.
# brittle where it should be a dumb representation of user object
# Builds the FROM and TO boxes from user object and props from queryparams
# from and to are plain decodeURIComponent urls
# which are then used to select defaultValue in the stateless ui component
{changeQueryParams} = require('../api/changeQueryParams.coffee')
Selected = require('../ui/Selected.coffee').Selected
{createContainer} = require 'meteor/react-meteor-data'
{see, store} = require '../api/strings.coffee'

# goes through a simple loop
#that builds list of objects from a number of sources.
exports.selectedContainer = createContainer ((props) ->
  # update queryparams unless we're fromt he same place

  nProps = _.extend {}, props,
    value: setValue(props,setOptions(props),props.user)
    options: setOptions(props)
  console.log nProps
  nProps
), Selected


setOptions = (props) ->
  options = []
  if props.user?.link?
    dictWithCreatedAt = props.user.link.to.Bookmarks
    deChaos = linkstate.sortByKeysTime dictWithCreatedAt
    for index,value of deChaos
      if typeof value is 'string' and value != 'undefined'
        entryWeightExists = dictWithCreatedAt[value]?.meta?.weight?
        entryWeightHigh = dictWithCreatedAt[value].meta.weight > 0
        if entryWeightExists and entryWeightHigh
          selectItem =
            label: dictWithCreatedAt[value].meta.title
            value: dictWithCreatedAt[value]
          options.push selectItem
        #else
        # console.log 'irrelevant entry', dictWithCreatedAt[value].meta.title
        # this needs cleaning up..? should we remove totally when 0
        # or should we filter the list every time we build the select...
        # this is executed a lot;.... so
  options

#FIXME does not select value when from a place
setValue = (props, options, user) ->
  newProps = {}
  newProps.options = []
  value = {}
  directedTo = typeof props.to is 'string' and props.to.length > 1
  clientReady = props.user?.services?.facebook? and Meteor.isClient
  gotFrom = typeof props.from is 'string' and props.from.length > 1
  bookmarked = props.user?.out?.Bookmarks?
  dictWithCreatedAt = props.user.link.to.Bookmarks
  console.log dictWithCreatedAt
  typeValue = props[props.type]
  dictValue = dictWithCreatedAt[linkstate.store(typeValue)]
  dictValueExists = dictValue?.meta?.title?
  lastDictValue = dictWithCreatedAt[linkstate.store(user[props.type+'Last'])]
  # what if ... you don't have a 'to' or from?  use
  # use if we don't have a to, we need to change queryParams to last to project
  if !typeValue? and lastDictValue?
    value=
      label: lastDictValue.meta.title
      value: lastDictValue
  #console.log dictValueExists, dictValue, props.type#, dictWithCreatedAt
  if props.type is 'from'
    if dictValueExists
      title = 'Linkstates for ' + dictValue.title + ' - ' + props.from
      #props.from
      DocHead.setTitle(title)

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
