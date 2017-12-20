# Selected.coffee
# FIXME major weakness of implementation.
# brittle where it should be a dumb representation of user object
# Builds the FROM and TO boxes from user object and props from queryparams
# from and to are plain decodeURIComponent urls
# which are then used to select defaultValue in the stateless ui component
{changeQueryParams} = require('../api/changeQueryParams.coffee')
Selected = require('../ui/SelectedUI.coffee').Selected
{createContainer} = require 'meteor/react-meteor-data'
{see, store} = require '../api/strings.coffee'

# goes through a simple loop
#that builds list of objects from a number of sources.
exports.selectedContainer = createContainer ((props) ->
  # update queryparams unless we're fromt he same place
  nProps = _.extend {}, props,
    value: setValue(props,setOptions(props),props.user)
    options: setOptions(props)
  nProps
), Selected

oDict = {}
vDict = {}
setOptions = (props) ->
  options = []
  if props.user?.links?.out?
    dictWithCreatedAt = props.user.links.out['Bookmarks']
    oDict = dictWithCreatedAt
    deChaos = linkstate.sortByKeysTime dictWithCreatedAt
    for index, value of deChaos
      continue if typeof value is not 'string'
      continue if value is 'undefined'
      console.log dictWithCreatedAt[value].meta.title
      continue unless dictWithCreatedAt[value]?.meta?.title?
      #continue unless dictWithCreatedAt[value].meta.weight > 0
      selectItem =
        label: dictWithCreatedAt[value].meta.title
        value: dictWithCreatedAt[value]
      #console.log selectItem
      options.push selectItem
      #else
      # console.log 'irrelevant entry', dictWithCreatedAt[value].meta.title
      # this needs cleaning up..? should we remove totally when 0
      # or should we filter the list every time we build the select...
      # this is executed a lot;.... so
  options

#FIXME does not select value when from a place
setValue = (props, options, user) ->
  console.log user, props.user
  newProps = {}
  newProps.options = []
  value = {}
  return unless props.user?.links?.out?['Bookmarks']?
  directedTo = typeof props.to is 'string' and props.to.length > 1
  clientReady = props.user?.services?.facebook? and Meteor.isClient
  gotFrom = typeof props.from is 'string' and props.from.length > 1
  bookmarked = props.user?.links?.out?.Bookmarks?
  dictWithCreatedAt = props.user.links.out['Bookmarks']
  vDict = dictWithCreatedAt
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
    # the issue is here
    #console.log oDict is vDict, dictValueExists, dictValue, props.type, value, dictWithCreatedAt, Meteor.user()#, dictWithCreatedAt
    #console.log oDict is vDict, dictValue, linkstate.store(typeValue), typeValue, linkstate.store('Linkstates.youiest.com')
    #console.log props.lastTitle, linkstate.store('Linkstates.youiest.com'),
    console.log typeValue, props.user.links.out.Bookmarks
    #console.log linkstate.unddot(dictValue)
    value =
      label: props.lastTitle
      value:
        meta:
          FromLink: props.from
          title: props.lastTitle

  value
