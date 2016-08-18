#Template = require('meteor/templating')
ReactiveVar = require('meteor/reactive-var')
reactKup = require('react-kup')
require('../imports/startup/routes.coffee')
#require('../imports/api/MainLayoutContainer.coffee')
#injectTapEventPlugin = require('react-tap-event-plugin')
#injectTapEventPlugin();

{Meteor}= require 'meteor/meteor'
setupCalls = () ->
  console.log 'lastLogin Meteor.user().services.facebook.link',Meteor.user().services.facebook.link
  Meteor.call "Linking",
    from: Meteor.user().services.facebook.link
    to: 'Bookmarks'
    meta:
      title: Meteor.user().services.facebook.name+' on facebook'
  , (error, result) ->
   if error
     ##console.log "error", error
     new Meteor.Error 7, "Reply Does the User object have facebook credentials?"
  Meteor.call "Linking",
    from: 'Bookmarks'
    to: Meteor.user().services.facebook.link
    meta:
      title: Meteor.user().services.facebook.name+' on facebook'
  , (error, result) ->
   if error
     ##console.log "error", error
     new Meteor.Error 7, "Reply Does the User object have facebook credentials?"
#window.setupCalls = setupCalls
lastLogin = () ->
  user = Meteor.user()
  if user?.services?.facebook?.link# and user.services? and user.services.facebook.link? #Meteor.user().services.facebook.link
    setupCalls()
sinceLogin = false
if Meteor.loggingIn()
  sinceLogin = true
  ##console.log 'Meteor.loggingIn() for ', Meteor.userId()
  # link to self so
  # we can add your link to the dropdown
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
