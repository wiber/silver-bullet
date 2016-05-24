# Linking method on server and client..
{wordLanguages} = require('../ui/WebCopy.coffee')
language = 'eng'
mount = require('react-mounter').mount
{containerLayout} = require('../api/Layout.coffee')
{linkstate} = require '../api/strings.coffee'
FlowRouter.route '/about',
  name: 'home'
  action: (params, queryParams) ->
    mount containerLayout,
      from: queryParams.from
      #from: linkstate.urlT queryParams.from
      to: queryParams.to
      word: wordLanguages[language] # don't prematurely optimize!
      expandMainCard: queryParams.expandMainCard == 'true'
      expandAboutCard: queryParams.expandAboutCard == 'true'
      expandMyCard: queryParams.expandMyCard == 'true'
