#Template = require('meteor/templating')
require("react/package.json")
ReactiveVar = require('meteor/reactive-var')
reactKup = require('react-kup')
require('../imports/startup/routes.coffee')
#require('../imports/api/MainLayoutContainer.coffee')
#injectTapEventPlugin = require('react-tap-event-plugin')
#injectTapEventPlugin();
@R = require('ramda')
{Meteor}= require 'meteor/meteor'



lastLogin = () ->
  user = Meteor.user()
  if user?.services?.facebook?.link
    Meteor.call "setupUser"

sinceLogin = false
if Meteor.loggingIn()
  sinceLogin = true
Meteor.startup ->
  sinceLogin = true
Tracker.autorun ->
  if Meteor.user() and sinceLogin
    lastLogin()
    sinceLogin = false

WebFontConfig = google: families: [ 'Roboto:400,300,500:latin' ]
do ->
  wf = document.createElement('script')
  wf.src = 'https://ajax.googleapis.com/ajax/libs/webfont/1/webfont.js'
  wf.type = 'text/javascript'
  wf.async = 'true'
  s = document.getElementsByTagName('script')[0]
  s.parentNode.insertBefore wf, s
  return
