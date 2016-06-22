{createContainer} = require 'meteor/react-meteor-data'

{Layout} = require '../ui/Layout.coffee'

exports.containerLayout = createContainer ((props) ->
  timePoll = (new Date().getTime() - Meteor.user().edited) <= 1000
  #console.log timePoll, props.from, 'propsFrom'
  if Meteor.isClient and Meteor.userId()? and props.from? and props.to? and !timePoll
    Meteor.call "Linking"
    , decodeURIComponent(props.from)
    , 'Jump-List'
    , (error, result) ->
  {
    #from: props.from # one arg?
    #to: props.to
    #expandMainCard: props.expandMainCard # all props
    user: Meteor.user()
  }
), Layout
