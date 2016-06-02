
@storageEncode = (url) ->
  #r = encodeURIComponent url
  r =  toString(url).replace /\./g , '%2E'
  console.log r
  return r

Meteor.methods
  resetUser: () ->
    user = Meteor.user()
    console.log user , 'whole'
    setter =
      in: user.in
      out: user.out
    console.log setter
    Meteor.users.update
      _id: Meteor.userId()
    ,
      $set:
        commit: setter
      $unset:
        dictTo: ''
        dictFrom: ''
        lastConnectedTo: ''

Meteor.methods
  Linking: (from, to, META) ->
    unless META?
      META = {}
    unless typeof Meteor.userId() is 'string'
      throw new Meteor.Error 1, "non-user tries to link"
      return 'nothing'

    unless typeof from is 'string' and typeof to is 'string'
      throw new Meteor.Error 2, "something wrong with orientation "+from+' '+to
      return 'nothing'
    console.log from, to, arguments

    FROM = do linkstate.store(from) # from.replace(/\./g,'%2E')
    TO = do linkstate.store(to) #to.replace(/\./g,'%2E')#.split('/').join('.');
    console.log FROM, TO, META
    time = new Date().getTime()
    name = 'Linking'
    edge = {}
    edge.from = FROM
    edge.to = TO
    edge.meta = META
    edge.author = Meteor.userId()
    edge.createdAt = time
    #  localStorage.setItem( linked, JSON.stringify( edge ) );
    username = Meteor.user().username
    setEdgeIn = {}
    setEdgeOut = {}
    # because these are like votes, you get a say about each link
    setEdgeIn['in.' + FROM + '.' + username] = edge
    edge.title = META.title or TO # because we're in TO this
    linked = Edges.insert(edge)
    setEdgeIn.title = edge.title
    # expresso dry left margin hugging coffee style

    toNodeId = Nodes.upsert
      _id: TO
    , # second argument to upsert "," is at same level, returns are free
      $set: setEdgeIn # set incoming edge where we're going TO impact
    console.log Nodes.findOne(toNodeId.insertedId)
    , ' updated node', toNodeId
    edge.title = META.title or FROM # because we're out FROM this
    setEdgeOut['out.' + TO + '.' + username] = edge
    setEdgeOut.title = edge.title
    fromNodeId = Nodes.upsert
      _id: FROM
    ,
      $set: setEdgeOut

    # this way it's an actual dictionary in the DB
    # we have your last link on your user object
    setIt = {}
    setIt['timeTo.'+TO] = time
    setIt['timeFrom.'+FROM] = time
    setIt['in.'+FROM+'.'+TO] = edge
    setIt['out.'+TO+'.'+FROM] = edge
    # by default we want to add it to the 'last used' url/collection /bookmark thing
    #setIt['lastConnectedTo'] = TO

    Meteor.users.update # we need to know what our last connection was
      _id: Meteor.userId()
    ,
      $set: setIt
    console.log Nodes.findOne(fromNodeId.insrtedId)


  Here: (URL) ->
    name = 'Here'
    #Meteor.subscribe "userData"
    console.log name, URL, Meteor.isServer, new Date()
    updateUserLandedWithTime = () ->
      unless !URL
        urlSet = {}
        time = new Date().getTime()
        urlSet.url = URL
        urlSet.time = time
        Meteor.users.update
          _id: Meteor.userId()
        ,
          $push:
            subscribed: urlSet
    if !Meteor.userId()
      new Meteor.Error 1, "Here not authentic"
    else
      updateUserLandedWithTime()
