{createContainer} = require 'meteor/react-meteor-data'

{Layout} = require '../ui/Layout.coffee'

exports.containerLayout = createContainer ((props) ->
  #timePoll = (new Date().getTime() - Meteor.user().edited) <= 1000
  #console.log timePoll, props.from, 'propsFrom'
  

  {
    #from: props.from # one arg?
    #to: props.to
    #expandMainCard: props.expandMainCard # all props
    user: Meteor.user()
  }
), Layout
