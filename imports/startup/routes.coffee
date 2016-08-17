# Linking method on server and client..
{wordLanguages} = require('../ui/WebCopy.coffee')
language = 'eng'
mount = require('react-mounter').mount
{containerLayout} = require('../api/Layout.coffee')
FlowRouter.route '/about',
  name: 'home'
  action: (params, queryParams) ->
    console.log queryParams
    mount containerLayout,
      queryParams: queryParams # to optiomize redraw on changed params
