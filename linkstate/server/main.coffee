require('react/package.json')
{Meteor} = require('meteor/meteor')
#reactKup = require('react-kup')
require '../imports/startup/configs/serviceconfiguration'
require('../imports/startup/routes.coffee') # one way to turn off ssr
require('../imports/startup/methods.coffee') # one way to turn off ssr
require('../imports/startup/publish.coffee') # one way to turn off ssr
{linkstate} = require '../imports/api/strings'
require('source-map-support').install()


@window = {}
@window.location = {}
@window.location.href = 'linkstate.youiest.com'
window.innerWidth = 640

Meteor.startup ->

  try
    #console.log process.env.MONGO_URL
    #console.log Meteor.settings, Meteor.settings?.MONGO_URL?
  catch error
    console.log error
if Meteor.loggingIn()
  Meteor.call "setupUser"
state =
  ssr: false
  timeInMillis: 1000 * 15
  window: window
# not using react layout so ssr wont' work
FlowRouter.setPageCacheTimeout state.timeInMillis
##console.log 'ssr', exports.state.ssr, exports.state.timeInMillis, window
FlowRouter.setDeferScriptLoading state.ssr
exports.state = state
