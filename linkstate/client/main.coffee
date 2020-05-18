#require '../imports/ui/materialize.min.css';
require '../imports/ui/style.css';
#Template = require('meteor/templating')
require("react/package.json")
ReactiveVar = require('meteor/reactive-var')
#reactKup = require('react-kup')
require('../imports/startup/routes.coffee')
require('../imports/startup/methods.coffee')
#require('../imports/api/MainLayoutContainer.coffee')
# injectTapEventPlugin = require('react-tap-event-plugin')
@R = require('ramda')
{Meteor} = require 'meteor/meteor'
require 'typeface-roboto'

# injectTapEventPlugin()
lastLogin = () ->
  user = Meteor.user()
  if user?.services?.facebook?.link
    Meteor.call "setupUser"

sinceLogin = false

# @elias, please provide with the logic definition.
# @nicolson if we have logged in with a facebook user,
# we need to setup that user with default data..
# couldn't think of a better way
# there are lots of these that need to be architected ..
# Why not use a flow router to fix the routing?
# Just a question..
if Meteor.loggingIn()
  sinceLogin = true
Meteor.startup ->
  sinceLogin = true
Tracker.autorun ->
  if Meteor.user() and sinceLogin
    lastLogin()
    sinceLogin = false

# FIXME not loading (?)
WebFontConfig = google: families: [ 'Roboto:400,300,500:latin' ]
wf = document.createElement('script')
wf.src = 'https://ajax.googleapis.com/ajax/libs/webfont/1/webfont.js'
wf.type = 'text/javascript'
wf.async = 'true'
s = document.getElementsByTagName('script')[0]
s.parentNode.insertBefore wf, s

loader = (link)=>
  ele = document.createElement('link');
  ele.href = link;
  document.body.appendChild(ele);
### load Disqus

script = document.createElement('script')
script.src = "//decivote.disqus.com/count.js"
script.async = true
script.id = "dsq-count-scr"
document.body.appendChild script

do ->
  # DON'T EDIT BELOW THIS LINE
  d = document
  s = d.createElement('script')
  s.src = 'https://decivote.disqus.com/embed.js'
  s.setAttribute 'data-timestamp', +new Date
  (d.head or d.body).appendChild s
  return
###
