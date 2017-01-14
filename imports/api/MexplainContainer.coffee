{changeQueryParams} = require('../api/changeQueryParams.coffee')
{createContainer} = require 'meteor/react-meteor-data'
{Mexplain} = require '../ui/mexplain.coffee'
console.log Mexplain
exports.Mexplain = createContainer ((props) ->
  newprops = Object.assign {}, props
  if Meteor.user()?.out?
    outlinks = Object.keys(Meteor.user().out)
    if outlinks.length > 4
      newprops.hide = true
  if Meteor.isServer
    newprops.hide = true
  newprops
), Mexplain
