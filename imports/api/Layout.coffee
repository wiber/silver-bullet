{createContainer} = require 'meteor/react-meteor-data'

{Layout} = require '../ui/Layout.coffee'

exports.containerLayout = createContainer ((props) ->
  {
    user: Meteor.user()
  }
), Layout
