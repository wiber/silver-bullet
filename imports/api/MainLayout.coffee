{createContainer} = require 'meteor/react-meteor-data'

{Layout} = require '../ui/MainLayout.coffee'

containerMainLayout = createContainer ((props) ->
  {
    #from: props.from # one arg?
    #to: props.to
    #expandMainCard: props.expandMainCard # all props
  }
), Layout
exports.containerMainLayout = containerMainLayout
