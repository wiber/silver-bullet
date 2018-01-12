R = require('ramda')
Lo = require 'lodash'
{linkstate} = require './strings'
oDict = {}
vDict = {}
hereAndThere = (user, props) ->
  {from,to} = props
  HERE = Lo.get props, 'user.links.in.Bookmarks.' + linkstate.store(from)
  HereScreenshotUrl = Lo.get HERE, 'meta.ScreenshotUrl'
  unless HERE?
    HERE =
      title: that.props.lastTitle
      from: that.props.from
    console.log 'we are noplace', HERE
  THERE = Lo.get props, 'user.links.in.Bookmarks.' + linkstate.store(to)
  ThereScreenshotUrl = Lo.get THERE, 'meta.ScreenshotUrl'
  return {HERE, HereScreenshotUrl, THERE, ThereScreenshotUrl}

# we need a tested way to extract select options, and a particular option selected among them
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
  console.log options.length, props
  options

#FIXME does not select value when from a place
setValue = (props, options, user) ->
  console.log options, user, props,'console.log options, user, props'
  newProps = {}
  newProps.options = []
  value = {}
  return unless props.user?.links?.in?['Bookmarks']?
  directedTo = typeof props.to is 'string' and props.to.length > 1
  clientReady = props.user?.services?.facebook?# and Meteor.isClient
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


exports.hereAndThere = hereAndThere
exports.setValue = setValue
exports.setOptions = setOptions
