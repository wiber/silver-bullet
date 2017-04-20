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
  FlowRouter.go('/about?from=https%253A%252F%252Fwww.linkstate.youiest.com&lastTitle=Linkstates')
