Meteor = require('meteor/meteor')
reactKup = require('react-kup')

require('../imports/startup/routes.coffee') # one way to turn off ssr

timeInMillis = 1000 * 10
FlowRouter.setPageCacheTimeout timeInMillis
@window = {}
window.innerWidth = 640
console.log 'ssr', timeInMillis, window
FlowRouter.setDeferScriptLoading true
