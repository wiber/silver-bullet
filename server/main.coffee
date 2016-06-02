Meteor = require('meteor/meteor')
reactKup = require('react-kup')
require '../imports/startup/configs/serviceconfiguration.js'

require('../imports/startup/routes.coffee') # one way to turn off ssr

timeInMillis = 1000 * 0
ssr = false
FlowRouter.setPageCacheTimeout timeInMillis
@window = {}
window.innerWidth = 640
console.log 'ssr', ssr, timeInMillis, window
FlowRouter.setDeferScriptLoading true
