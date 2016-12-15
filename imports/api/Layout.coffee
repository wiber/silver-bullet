{createContainer} = require 'meteor/react-meteor-data'
{wordLanguages} = require('../ui/WebCopy.coffee')
language = 'eng'
{Layout} = require '../ui/Layout.coffee'
{changeQueryParams} = require('../api/changeQueryParams.coffee')


containerLayout = createContainer ((props) ->
  queryParams = props.queryParams
  user = Meteor.user()
  content = ifBodyContentHere queryParams.content, queryParams
  unless FlowRouter.getQueryParam('Bookmarked')
    if samePlace(user, queryParams) and Meteor.isClient
      console.log UserHandle.ready(), user,'console.log UserHandle.ready(), user'
      changeQueryParams('Bookmarked', true)
      Meteor.call "Linking",
        from: queryParams.from
        to: 'Bookmarks'
        meta:
          title: queryParams.lastTitle
  if Meteor?.settings?.public?.thumbalizr? # user?.services?.thumbalizr?
    thumbalizr = Meteor.settings.public.thumbalizr
  else
    thumbalizr = undefined
  {
    user: user
    thumbalizr: thumbalizr
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

# textbox should have your comment in it if empty
ifBodyContentHere = (paramContent, queryParams)->
  if paramContent is 'undefined' or typeof paramContent is 'undefined'
    console.log "if paramContent is 'undefined'", queryParams
    content = ''
  if Meteor.isClient and UserHandle.ready() and Meteor.user()?.lastFrom?
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
  console.log paramContent, content, "log paramContent, content"
  if typeof content is 'undefined'
    return ''
  else
    return content

samePlace = (user, queryParams) ->
  flag = false
  if user?.fromLast?
    if user.fromLast != queryParams.from
      flag = true
  else # if we never been anyplace, we're new here
    flag = true
  flag

exports.containerLayout = containerLayout
