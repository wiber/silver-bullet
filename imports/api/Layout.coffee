{createContainer} = require 'meteor/react-meteor-data'

{Layout} = require '../ui/Layout.coffee'

exports.containerLayout = createContainer ((props) ->
  {
    #from: props.from # one arg?
    #to: props.to
    #expandMainCard: props.expandMainCard # all props
  }
), Layout
