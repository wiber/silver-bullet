{wordLanguages} = require('../ui/WebCopy.coffee')
language = 'eng'
mount = require('react-mounter').mount
{containerLayout} = require('../api/Layout.coffee')

FlowRouter.route '/about',
  name: 'home'
  action: (params, queryParams) ->
    mount containerLayout,
      queryParams: queryParams # to optiomize redraw on changed params

FlowRouter.route '/',
  name: 'front'
  action: (params, queryParams) ->
    FlowRouter.go('/about?from=https%253A%252F%252Flinkstate.youiest.com%252F&lastTitle=Linkstates')
