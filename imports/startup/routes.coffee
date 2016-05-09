# Linking method on server and client..
require '../api/linking.coffee'
{wordLanguages} = require('../ui/WebCopy.coffee')
language = 'eng'
mount = require('react-mounter').mount
containerMainLayout = require('../api/MainLayout.coffee').containerMainLayout

FlowRouter.route '/about',
  name: 'home'
  action: (params, queryParams) ->
    mount containerMainLayout,
      from: queryParams.from
      to: queryParams.to
      word: wordLanguages[language]
      expandMainCard: queryParams.expandMainCard == 'true'
