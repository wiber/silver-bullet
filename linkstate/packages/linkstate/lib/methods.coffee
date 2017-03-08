
{check} = require 'meteor/check'
@storageEncode = (url) ->
  #r = encodeURIComponent url
  r =  toString(url).replace /\./g , '%2E'
  ##console.log r
  return r
@categoryTypes = [
  'Bookmarks'
  'Categories'
]

if Meteor.settings?.public?.thumbalizr?
  @thumbalizr =  Meteor.settings.public.thumbalizr
else
  @thumbalizr= "5VmUR42gc4eGdLjBnZH2BRXa"

Meteor.methods
  Linking: (link) ->
    #this.unblock() # allow next req without wait
    #check(link.from,'string')
    to = link.to
    from = link.from
    META = link.meta
    unless META?
      META = {}
    unless META.title?
      META.title = to
    unless typeof Meteor.userId() is 'string'
      throw new Meteor.Error 1, "non-user tries to link"
      return 'nothing'
    else
      console.log 'Linking'
      ,@isSimulation
      , link.from
      , link.meta.weight
      , link.to
      , Meteor.user().hits
      , Meteor.user()?.services?.facebook?.name #,  Meteor.user().profile.name
      , Meteor.user().hits
    unless to? and from?
      throw new Meteor.Error 2, "to or from is missing "+from+' '+to
      return 'nothing'
    if Meteor.user()?.services?.facebook?.id?
      META.face = "http://graph.facebook.com/v2.7/" + Meteor.user().services.facebook.id + "/picture?type=square"
      META.profileLink = Meteor.user().services.facebook.link
    FROM = linkstate.store(from) # from.replace(/\./g,'%2E')
    TO = linkstate.store(to) #to.replace(/\./g,'%2E')#.split('/').join('.');
    time = new Date().getTime()
    name = 'Linking'
    edge = {}
    edge.from = FROM
    edge.to = TO
    edge.meta = META
    edge.meta.FromLink = from
    edge.meta.ToLink = to
    edge.meta.ScreenshotUrl = "https://api.thumbalizr.com/?url="+from+"&width=250&api_key="+thumbalizr
    edge.meta.ScreenshotUrlTo = "https://api.thumbalizr.com/?url="+to+"&width=250&api_key="+thumbalizr
    edge.author = Meteor.userId()
    edge.createdAt = time
    username = Meteor.user().profile.name
    setEdgeIn = {}
    setEdgeOut = {}
    setEdgeIn['out.' + FROM + '.' + username] = edge
    edge.title = META.title# or TO # because we're in TO this
    setEdgeIn.title = edge.title
    edge.title = META.title or FROM # because we're out FROM this
    setEdgeOut['in.' + TO + '.' + username] = edge
    setEdgeOut.title = edge.title

    setIt = {}
    setIt.edited = time
    if from not in categoryTypes
      setIt.fromLast = from
    if to not in categoryTypes
      setIt.toLast = to
    setIt['in.'+FROM+'.'+TO] = edge
    setIt['out.'+TO+'.'+FROM] = edge
    # totally kills latency compensation on page load to avoid uncaught error in fast render
    if Meteor.isServer or UserHandle?.ready()
      Meteor.users.update # we need to know what our last connection was
        _id: Meteor.userId()
      ,
        $set: setIt
        $inc:
          'hits': 1
    Meteor.call 'secondaryLinking',
      FROM: FROM
      TO: TO
      edge: edge
      setEdgeOut: setEdgeOut
      setEdgeIn: setEdgeIn

  checkHits: ->
    if Meteor.isServer
      hits = Meteor.user().hits
      name = Meteor.user().services.facebook.name if Meteor.user()?.services?.facebook?.name? # Meteor.user()?.services?.facebook?.name? ?  #: 'no user'
      console.log 'Meteor.user().hits', hits, 'checkHits server', name
  	  return hits

  secondaryLinking: (payload) ->
    if Meteor.isServer
      fromNodeId = Nodes.upsert
        _id: payload.FROM
      ,
        $set: payload.setEdgeOut
      toNodeId = Nodes.upsert
        _id: payload.TO
      ,
        $set: payload.setEdgeIn # set incoming edge where we're going TO impact
      linked = Edges.insert(payload.edge)
  setupUser: () ->
    Meteor.users.update
      _id: Meteor.userId()
    ,
      $set:
        'services.thumbalizr': Meteor.settings.thumbalizr
        #'fromLast': Meteor.user().services.facebook.link
        #'toLast': 'Bookmarks'
    console.log 'Just setupUser', Meteor.user()

    Meteor.call "Linking",
      from: 'Bookmarks' # systems types.. need to be from bookmarks if they are to be picked up?
      to: 'Bookmarks' # the thing we're defining
      meta:
        title: 'Your Bookmarks'
    , (error, result) ->
     if error
       ##console.log "error", error
       new Meteor.Error 7, "Reply Does the User object have facebook credentials?"
    if Meteor.user()?.services?.facebook?.link?
      Meteor.call "Linking",
        from: Meteor.user().services.facebook.link
        to: 'Bookmarks'
        meta:
          title: Meteor.user().services.facebook.name+' on Facebook'
    else
      new Meteor.Error 22, "non facebook user tried to login"
  compareHits: ->
    if Meteor.isClient
      Meteor.call "checkHits", (error, result) ->
        if error
          console.log "error", error
        if result
          #console.log result, Meteor.user().hits, result is Meteor.user().hits, 'because it should be'
          unless result is Meteor.user().hits
            new Meteor.Error 16, "sync error? looks like user object not synced"
          localStorage.setItem 'serverHits', result
          console.log localStorage.getItem( 'serverHits'), Meteor.user().hits, result is Meteor.user().hits,'compareHits withResult'
      #console.log localStorage.getItem( 'serverHits'), Meteor.user().hits, 'compareHits without'

    #if Meteor.isSimulation
    #  Meteor.call "compareHits"
    #return new Date()
  resetUser: () ->
    user = Meteor.user()
    ##console.log user , 'whole'
    setter = {}
    setter['commit.'+new Date().getTime()] =
      in: user.in
      out: user.out
    setter['services.thumbalizr'] = Meteor.settings.thumbalizr
    Meteor.users.update
      _id: Meteor.userId()
    ,
      $set: setter
      $unset:
        dictTo: ''
        dictFrom: ''
        lastConnectedTo: ''
        in: ''
        out: ''
        timeTo: ''
        timeFrom: ''
        when: ''
        fromLast: ''
        hits: ''
        lastTo: ''
        lastFrom: ''
        fromLast: ''
        toLast: ''
        toCreated: ''
        fromCreated: ''
        thumbalizr: ''
    Meteor.call "setupUser"

  #defines naming conventions for categoryTypes
