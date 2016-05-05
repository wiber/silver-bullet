
mount = require('react-mounter').mount
containerMainLayout = require('../api/containerMainLayout.coffee').containerMainLayout

FlowRouter.route '/about',
  name: 'home'
  action: (params, queryParams) ->
    mount containerMainLayout,
      from: queryParams.from
      to: queryParams.to
      expandMainCard: queryParams.expandMainCard == 'true'
