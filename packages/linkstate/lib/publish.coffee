# reactively publishes last n nodes you landed on
# this includes changing dropdown selection because
# it counts as a new route call, calls linking again
# if it's the 'from' queryparams.
# because we want to know the last time you were 'here' ie to Bookmarks
# because we want to be sure of what we are subscribed to right now
Meteor.publish "Node", (from) ->
  one = Nodes.find
    _id: linkstate.store from
  all = Nodes.find {}
 #console.log linkstate.store from, from, one, all.count(), 'NNN'
  return one

Meteor.publish 'reactableFrom', (howMany) ->
  @autorun (computation) ->
    user = Meteor.users.findOne @userId,
      fields:
        'out.Bookmarks': 1
    if user?.to?
      fromLast = linkstate.sortByKeysTime user.to['Bookmarks']
      return Nodes.find
        _id:
          $in: fromLast[0..howMany]

Meteor.publish 'userData', ->
  ##console.log @userId, 'wants user obj'
  user = {}
  if @userId
    user = Meteor.users.find
      _id: @userId
    ,
      fields:
        'services.facebook.accessToken': 0
        'services.resume': 0
  user

Meteor.publish 'to', (URL) ->
  ##console.log Edges.find().fetch().length, 'just len'
  ##console.log 'one to',URL,Edges.findOne({from:URL})
  return Edges.find
    to: linkstate.toDotless(URL)
Meteor.publish 'from', (URL) ->
  ##console.log Edges.find().fetch().length, 'just len'
  ##console.log 'one from',URL,Edges.findOne({from:URL})
  return Edges.find
    from: linkstate.toDotless(URL)

Meteor.publish "myMarks", () ->
  unless !@userId # can't do it
    Edges.find
      author: @userId
    ,
      limit: 100
      sort:
        createdAt: -1

Meteor.publish "myMarksFrom", (URL) ->
  unless !@userId # can't do it
    Edges.find
      author: @userId
      from: URL
    ,
      limit: 20
      sort:
        createdAt: -1
Meteor.publish "myMarksTo", (URL) ->
  unless !@userId # can't do it
    Edges.find
      author: @userId
      from: URL
    ,
      limit: 20
      sort:
        createdAt: -1
