{createContainer} = require 'meteor/react-meteor-data'
{wordLanguages} = require('../ui/WebCopy.coffee')
language = 'eng'
{Layout} = require '../ui/Layout.coffee'
{changeQueryParams} = require('../api/changeQueryParams.coffee')

exports.containerLayout = createContainer ((props) ->
  Meteor.subscribe "userData"
  newProps = {}
  newProps.user = Meteor.user()
  queryParams = props.queryParams
  content = decodeURIComponent queryParams.content
  if content is 'undefined'
    content = ''
 #console.log queryParams, FlowRouter.getQueryParam('Bookmarked')
  unless FlowRouter.getQueryParam('Bookmarked')
    samePlace = false
    if Meteor.user()?.fromLast?
      if Meteor.user().fromLast != queryParams.from
        samePlace = true
    else
      samePlace = true
   #console.log samePlace, Meteor.user().fromLast, queryParams.from
    if Meteor.user() and samePlace and Meteor.isClient
      changeQueryParams('Bookmarked', true)
      # otherwise leads to a flip/flop issue when two tabs are open
      # how do we detect if this was the first time the tab opened?
      # by using a queryParams... for already called bookmarked
      Meteor.call "Linking",
        from: decodeURIComponent queryParams.from
        to: 'Bookmarks'
        meta:
          title: queryParams.lastTitle
      , (error, result) ->
        if error
         console.log "error", error
        if result
         console.log 'result', result
    props = _.extend {}, props, newProps
  {
    user: Meteor.user()
    from: decodeURIComponent queryParams.from
    to: decodeURIComponent queryParams.to
    content: content
    fromTitle: decodeURIComponent queryParams.lastTitle
    word: wordLanguages[language] # don't prematurely optimize!
    expandMainCard: queryParams.expandMainCard != 'false'
    expandAboutCard: queryParams.expandAboutCard != 'false'
    expandMyCard: queryParams.expandMyCard != 'false'
  }
), Layout
