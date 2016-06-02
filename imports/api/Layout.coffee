{createContainer} = require 'meteor/react-meteor-data'

{Layout} = require '../ui/Layout.coffee'

exports.containerLayout = createContainer ((props) ->
  console.log Meteor.user()
  {
    #from: props.from # one arg?
    #to: props.to
    #expandMainCard: props.expandMainCard # all props
    user: Meteor.user()
  }
), Layout
