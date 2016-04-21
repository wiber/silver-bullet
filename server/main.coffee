Meteor = require('meteor/meteor')
reactKup = require('react-kup')

require('../imports/startup/routes.coffee')

timeInMillis = 1000 * 10
FlowRouter.setPageCacheTimeout timeInMillis
console.log 'ssr', timeInMillis
FlowRouter.setDeferScriptLoading true
