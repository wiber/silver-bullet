Meteor = require('meteor/meteor')
reactKup = require('react-kup')
require '../imports/startup/configs/serviceconfiguration.js'
require('../imports/startup/routes.coffee') # one way to turn off ssr
@window = {}
window.innerWidth = 640

exports.state =
  ssr: true
  timeInMillis: 1000 * 15
  window: window

FlowRouter.setPageCacheTimeout exports.state.timeInMillis
##console.log 'ssr', exports.state.ssr, exports.state.timeInMillis, window
FlowRouter.setDeferScriptLoading exports.state.ssr
