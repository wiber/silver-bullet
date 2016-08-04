{createContainer} = require 'meteor/react-meteor-data'

{Layout} = require '../ui/Layout.coffee'

exports.containerLayout = createContainer ((props) ->
  queryParams = props.queryParams
  #timePoll = (new Date().getTime() - Meteor.user().edited) <= 1000
  ##console.log timePoll, props.from, 'propsFrom'
  if Meteor.user().fromLast?
    samePlace = false
    if Meteor.user().fromLast != queryParams.from
      samePlace = true
  #samePlace = Meteor.user().fromLast != queryParams.from
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
  }
), Layout
