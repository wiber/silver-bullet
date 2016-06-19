#Template = require('meteor/templating')
ReactiveVar = require('meteor/reactive-var')
reactKup = require('react-kup')
require('../imports/startup/routes.coffee')
#require('../imports/api/MainLayoutContainer.coffee')
#injectTapEventPlugin = require('react-tap-event-plugin')
#injectTapEventPlugin();
{Meteor}= require 'meteor/meteor'
lastLogin = () ->
  user = Meteor.user()
  if user? and user.services? and user.services.facebook.link? #Meteor.user().services.facebook.link
    Meteor.call "Linking"
    , Meteor.user().services.facebook.link
    , 'Yours-Truly'
    , (error, result) ->
     if error
       console.log "error", error
       new Meteor.Error 7, "Reply Does the User object have facebook credentials?"
     if result
       console.log result

sinceLogin = false
if Meteor.loggingIn()
  sinceLogin = true
  console.log 'Meteor.loggingIn() for ', Meteor.userId()
  # link to self so
  # we can add your link to the dropdown
Meteor.startup ->
	sinceLogin = true
Tracker.autorun ->
  if Meteor.user() and sinceLogin
    console.log 'tracker started for ', Meteor.userId(), sinceLogin
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
