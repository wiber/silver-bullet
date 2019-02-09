{changeQueryParams} = require('../api/ModelOperations.coffee')
{createContainer} = require 'meteor/react-meteor-data'
{Mexplain} = require '../ui/mexplain.coffee'
exports.Mexplain = createContainer ((props) ->
  newprops = Object.assign {}, props
  if Meteor.user()?.out?
    # another issue.
    # the model namespaces are all over the place.
    # changes in one place affect many.
    # we need to have functions in ModelOperations.coffee
    # to get outLinks, or whatever we need
    # from the model. by calling a function.
    # @nicolson
    outlinks = Object.keys(Meteor.user().out)
    if outlinks.length > 4
      newprops.hide = true
  if Meteor.isServer
    newprops.hide = true
  newprops
), Mexplain
