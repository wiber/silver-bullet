{createContainer} = require 'meteor/react-meteor-data'
{wordLanguages} = require('../ui/WebCopy.coffee')
language = 'eng'
{Layout} = require '../ui/Layout.coffee'
{changeQueryParams} = require('../api/changeQueryParams.coffee')

exports.containerLayout = createContainer ((props) ->
  queryParams = props.queryParams
  content = decodeURIComponent queryParams.content
  user = Meteor.user()
  # when textfield is empty, fill it with your comment on this connection, if exist
  ifBodyContentHere = (paramContent)->
    if paramContent is 'undefined'
      content = ''
    if Meteor.isClient and UserHandle.ready()
      user = Meteor.user()
      to = linkstate.store queryParams.to
      from = linkstate.store queryParams.from
      lastFrom = user.lastFrom
      switched = lastFrom != queryParams.from
      cInExists = user.out[to]?[from]?
      if cInExists
        console.log paramContent
        , user.out[to][from]
        , user.out[to][from].meta.body
      if cInExists and switched
        cIn = user.out[to][from]
        changeQueryParams 'content', cIn.meta.body # 'content', cIn,
        content = cIn.meta.body
    return content
  content = ifBodyContentHere queryParams.content
  console.log content, 'cin remade'
  unless FlowRouter.getQueryParam('Bookmarked')
    samePlace = false
    if Meteor.user()?.fromLast?
      if Meteor.user().fromLast != queryParams.from
        samePlace = true
    else # if we never been anyplace, we're new here
      samePlace = true
   #console.log samePlace, Meteor.user().fromLast, queryParams.from
    if Meteor.user() and samePlace and Meteor.isClient
      changeQueryParams('Bookmarked', true)
     #console.log'Linking because samePlace', samePlace, queryParams.from, Meteor.user(), decodeURIComponent queryParams.from
      # otherwise leads to a flip/flop issue when two tabs are open
      # how do we detect if this was the first time the tab opened?
      # by using a queryParams... for already called bookmarked
      Meteor.call "Linking",
        from: queryParams.from
        to: 'Bookmarks'
        meta:
          title: queryParams.lastTitle
  {
    user: user
    from: decodeURIComponent queryParams.from
    to: decodeURIComponent queryParams.to
    incomming: queryParams.incomming
    content: content
    fromTitle: decodeURIComponent queryParams.lastTitle
    word: wordLanguages[language] # don't prematurely optimize!
    expandMainCard: queryParams.expandMainCard != 'false'
    expandAboutCard: queryParams.expandAboutCard != 'false'
    expandMyCard: queryParams.expandMyCard != 'false'
  }
), Layout
