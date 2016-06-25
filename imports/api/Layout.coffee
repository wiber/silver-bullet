{createContainer} = require 'meteor/react-meteor-data'

{Layout} = require '../ui/Layout.coffee'

exports.containerLayout = createContainer ((props) ->
  #timePoll = (new Date().getTime() - Meteor.user().edited) <= 1000
  #console.log timePoll, props.from, 'propsFrom'
  milliseconds = 15
  #if deThrasher?
  #  clearTimeout deThrasher
  dangerous =# () ->
    Meteor.call "Linking",
      from: decodeURIComponent(props.from)
      to: 'Jump-List'
  slowed = _.throttle dangerous, 1000
  if Meteor.isClient
    try
      lastJump = linkstate.sortByKeysTime Meteor.user().out['Jump-List'], 1
      console.log 'should weLinking?',lastJump[0], props.from, lastJump[0] is props.from
      lastJumpUrl = Meteor.user().out['Jump-List'][lastJump[0]].meta.FromLink
      if lastJumpUrl? and props.from?
        unless lastJumpUrl is props.from
          console.log 'lets Linking', lastJumpUrl
          slowed()
    catch error
      console.log error

  {
    #from: props.from # one arg?
    #to: props.to
    #expandMainCard: props.expandMainCard # all props
    user: Meteor.user()
  }
), Layout
