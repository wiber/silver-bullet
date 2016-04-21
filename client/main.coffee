#Template = require('meteor/templating')
ReactiveVar = require('meteor/reactive-var')
reactKup = require('react-kup')
require('../imports/startup/routes.coffee')
#require('../imports/api/MainLayoutContainer.coffee')
#injectTapEventPlugin = require('react-tap-event-plugin')
#injectTapEventPlugin();

WebFontConfig = google: families: [ 'Roboto:400,300,500:latin' ]
do ->
  wf = document.createElement('script')
  wf.src = 'https://ajax.googleapis.com/ajax/libs/webfont/1/webfont.js'
  wf.type = 'text/javascript'
  wf.async = 'true'
  s = document.getElementsByTagName('script')[0]
  s.parentNode.insertBefore wf, s
  return
