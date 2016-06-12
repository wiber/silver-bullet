# Selected.coffee
# Builds the FROM and TO boxes from user object


Selected = require('../ui/Selected.coffee').Selected
{createContainer} = require 'meteor/react-meteor-data'
{see, store} = require '../api/strings.coffee'
{changeQueryParams} = require '../api/changeQueryParams.coffee'

# TODO use dictionary here instead to avoid dupes?
# Make a field on user object that exactly correlates with what should be in selectedContainer
# goes through a simple loop that builds list of objects from a number of sources.
# later, would need to have a custom rendering so it gets mini screenshot and a descriptor of why it is here
# in method pre build the selectedContainer object with all kinds...
# method to set up 'me' facebook obj, etc as dict

deduperObject = {}
# build the array from the user object in and out ..

# Meteor.user().in
# has a dict like this
# FROM:
exports.selectedContainer = createContainer ((props) ->

  from = typeof props.from is 'string'
  to =  typeof props.to is 'string'
  console.log props, from, to,  'before stringing'
  # TODO make sure no dupes enter dropdown
  # TODO make sure a standardized approach is used to select from dropdown
  # original url is decodeURIComponent, then to storage, for keys and storage
  # do store key is used for props
  fromWhere = {}
  fromProp = {}
  toProp = {}
  newProps = {}
  newProps.options = []
  timeNow =
    createdAt: new Date().getTime()
  fromQueryParams = {}
  # extreme isomorphism, use db to keep string format consistency, on client, because it's just a function call
  # on your user() keep state of your queryparam
  # throttling and double writes can be easily? handled later

    #newProps.to = linkstate.store decodeURIComponent props.from
    #fromQueryParams[newProps.to] = timeNow
  #else
  #  toProp['Meteor.user().services.facebook.email'] = timeNow
  if typeof Meteor.user().out is 'object'
    console.log linkstate.sortByKeysTime(Meteor.user().out['Jump-List'])[0]
    deChaos = linkstate.sortByKeysTime _.extend {}
    , Meteor.user().out # from db
    , Meteor.user().in
    , fromQueryParams # from param
    for index,value of deChaos
      console.log index, value, linkstate.store value,'from sorted'
      if typeof value is 'string'
        newProps.options.push
          label: linkstate.see value
          value: value #linkstate.store value
  defaultValue = _.find newProps.options, (obj) ->
    obj.value == props[props.type]
  console.log newProps, newProps.from is newProps.to, newProps.options is _.uniq newProps.options, defaultValue
  newProps
), Selected
