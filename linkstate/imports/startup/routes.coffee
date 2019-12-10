{wordLanguages} = require('../ui/WebCopy.coffee')
language = 'eng'
mount = require('react-mounter').mount

containerLayout = require('../api/Layout.coffee').containerLayout
{AccountsUIWrapper} = require '../ui/AccountsUIWrapper.coffee'
{ HomePage } = require '../ui/HomePage.jsx'
{ Login } = require '../ui/Login.coffee'

FlowRouter.route '/about',
  name: 'home'
  action: (params, queryParams) ->
    title = "Linkstates for "+queryParams.title
    # this works (and updates) but facebook doesn't pick it up
    DocHead.addMeta #og:image
      property: "og:title",
      content: title
    document.title = title
    console.log {title,queryParams},document.title, document.getElementsByTagName('meta')[0]
    mount containerLayout,
      queryParams: queryParams # to optiomize redraw on changed params
    # if Meteor.userId()
    #   mount containerLayout,
    #     queryParams: queryParams # to optiomize redraw on changed params
    # else
    #   FlowRouter.go '/home'

FlowRouter.route '/',
  name: 'front'
  action: (params, queryParams) ->
    FlowRouter.go '/about?from=https%253A%252F%252Flinkstate.youiest.com%252F&lastTitle=Linkstates'
    # if Meteor.userId()
    #   FlowRouter.go '/about?from=https%253A%252F%252Flinkstate.youiest.com%252F&lastTitle=Linkstates'
    # else
    #   FlowRouter.go '/home'

FlowRouter.route '/login',
  name: 'login'
  action: (params, queryParams) ->
    mount AccountsUIWrapper

FlowRouter.route '/experiment',
  name: 'experiment'
  action: (params, queryParams) ->
    mount Login


FlowRouter.route '/home',
  name: 'home'
  action: (params, queryParams) ->
    FlowRouter.go '/about?from=https%253A%252F%252Flinkstate.youiest.com%252F&lastTitle=Linkstates'
    # mount HomePage

exports.xyz = null
