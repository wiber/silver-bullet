
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
      dictTo: user.dictTo
      dictoFrom: user.dictFrom
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
    unless Meteor.userId()
      throw new Meteor.Error 1, "non-user tries to link"
      return 'nothing'

    unless typeof from is 'string' and typeof to is 'string'
      throw new Meteor.Error 1, "non-user tries to link"
      return 'nothing'
    console.log from, to, arguments

    FROM = from.replace(/\./g,'%2E')
    #TO = storageEncode to
    TO = to.replace(/\./g,'%2E')#.split('/').join('.');
    console.log FROM, TO, META
    time = new Date().getTime()
    name = 'Linking'
    edge = {}
    edge.from = FROM
    edge.to = TO
    edge.meta = META
    edge.author = Meteor.userId()
    edge.createdAt = time

    linked = Edges.insert(edge)
    #  localStorage.setItem( linked, JSON.stringify( edge ) );
    username = Meteor.user().username
    setEdgeIn = {}
    setEdgeOut = {}
    # because these are like votes, you get a say about each link
    setEdgeIn['in.' + FROM + '.' + username] = edge
    edge.title = META.title or TO # because we're in TO this
    setEdgeIn.title = edge.title
    # expresso dry left margin hugging coffee style
    # coffee welcomes return characters, offers lots of air
    toNodeId = Nodes.upsert
      _id: TO
    , # second argument to upsert "," is at same leve, returns are free
      $set: setEdgeIn # set incoming edge where we're going TO impact

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
    setIt['dictTo.'+TO] = time
    setIt['dictFrom.'+FROM] = time
    setIt['dictF.'+FROM+'.'+TO] = edge
    setIt['dictT.'+TO+'.'+FROM] = edge
    # by default we want to add it to the 'last used' url/collection /bookmark thing
    #setIt['lastConnectedTo'] = TO

    Meteor.users.update # we need to know what our last connection was
      _id: Meteor.userId()
    ,
      $set: setIt
    console.log Nodes.findOne(fromNodeId)


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
