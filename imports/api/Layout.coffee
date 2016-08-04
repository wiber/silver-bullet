{createContainer} = require 'meteor/react-meteor-data'
{wordLanguages} = require('../ui/WebCopy.coffee')
language = 'eng'
{Layout} = require '../ui/Layout.coffee'

exports.containerLayout = createContainer ((props) ->
  queryParams = props.queryParams
  content = decodeURIComponent queryParams.content
  if content is 'undefined'
    content = ''
  console.log queryParams
  if Meteor.user()?.fromLast?
    samePlace = false
    if Meteor.user().fromLast != queryParams.from
      samePlace = true
  console.log samePlace, Meteor.user().fromLast, queryParams.from
  if Meteor.user() and samePlace and Meteor.isClient
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


  {
    #from: props.from # one arg?
    #to: props.to
    #expandMainCard: props.expandMainCard # all props
    user: Meteor.user()
    from: decodeURIComponent queryParams.from
    to: decodeURIComponent queryParams.to
    content: content
    fromTitle: decodeURIComponent queryParams.lastTitle
    word: wordLanguages[language] # don't prematurely optimize!
    expandMainCard: queryParams.expandMainCard == 'true'
    expandAboutCard: queryParams.expandAboutCard == 'true'
    expandMyCard: queryParams.expandMyCard == 'true'
  }
), Layout
