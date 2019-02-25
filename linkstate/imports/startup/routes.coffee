{wordLanguages} = require('../ui/WebCopy.coffee')
language = 'eng'
mount = require('react-mounter').mount
import { containerLayout }  from  ('../api/Layout.coffee')
{AccountsUIWrapper} = require '../ui/AccountsUIWrapper.coffee'
{ HomePage } = require '../ui/HomePage.jsx'

FlowRouter.route '/about',
  name: 'home'
  action: (params, queryParams) ->
    if Meteor.userId()
      # mount containerLayout,
      #   queryParams: queryParams # to optiomize redraw on changed params
    else
      FlowRouter.go '/home'

FlowRouter.route '/',
  name: 'front'
  action: (params, queryParams) ->
    if Meteor.userId()
      FlowRouter.go '/about?from=https%253A%252F%252Flinkstate.youiest.com%252F&lastTitle=Linkstates'
    else
      FlowRouter.go '/home'
FlowRouter.route '/login',
  name: 'login'
  action: (params, queryParams) ->
    mount AccountsUIWrapper


FlowRouter.route '/home',
  name: 'home'
  action: (params, queryParams) ->
    mount HomePage

exports.xyz = null