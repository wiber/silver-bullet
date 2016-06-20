#@uri = (URL) ->
#@uri = (URL) ->
Meteor.publish 'userData', ->
  #console.log @userId, 'wants user obj'
  if @userId
    return Meteor.users.find
      _id: @userId
    ,
      fields:
        'services.facebook.accessToken': 0
        'services.resume': 0

Meteor.publish 'to', (URL) ->
  #console.log Edges.find().fetch().length, 'just len'
  #console.log 'one to',URL,Edges.findOne({from:URL})
  return Edges.find
    to: linkstate.toDotless(URL)
Meteor.publish 'from', (URL) ->
  #console.log Edges.find().fetch().length, 'just len'
  #console.log 'one from',URL,Edges.findOne({from:URL})
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
Meteor.publish "Node", (URL) ->
  check URL, String
  return Nodes.find(URL)
# first see related
## in lightbox? esc to leave, same as clocks
# then see votes faces
# then see mine first
# why isn't api uniform between user and node? is it?
Meteor.publish 'uri', (URL) ->
  if !@userId
    #new Meteor.Error 2, "non-user tries to access public node" # so let them
    #console.log Nodes.find(URL), 'uri returns logged out'
    return Nodes.find(storageEncode(URL))
  else
    #console.log Nodes.findOne(storageEncode(URL))
    return Nodes.find(storageEncode(URL))
    ###
    user = Meteor.users.findOne @userId
    if !user.subscribed
      user.subscribed = [ @userId ]
      Meteor.users.update
        _id: @userId
      , # nice pattern for updates
        $set:
          subscribed: [@userId]
      subscribeTo = user.subscribed[0..9]
      toReturn = Nodes.find ({'_id': {'$in': subscribeTo}})
      ##console.log toReturn.fetch(), subscribeTo, 'toReturn'
      return toReturn ###
