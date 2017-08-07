
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
  NewQueryParams: (queryParams) ->
    if Meteor.isClient and Meteor.user()?.link?
      console.log Meteor.user(), queryParams
      console.log Meteor.user()?.queryParamsState?
    payload =
      queryParamsState: queryParams
    Meteor.users.update
      _id: Meteor.userId()
    ,
      $set: payload
      $inc:
        'qpUpdates': 1
    if Meteor.isClient
      console.log Meteor.user()?.queryParamsState?

  GroundedUserInsert: ->
    if Meteor.isClient and Meteor.user().services?.facebook?
      localStorage.setItem 'latest', JSON.stringify(Meteor.user())
  GroundedNodeInsert: ->
    if Meteor.isClient and Meteor.user().services?.facebook?
      console.log Nodes.findOne()
      localStorage.setItem Nodes.findOne()._id, JSON.stringify(Nodes.findOne())
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
      if Meteor.user()?.hits?
        console.log 'Linking'
        , @isSimulation
        , META.title
        , link.from
        , link.meta.weight
        , link.to
        , Meteor.user()?.services?.facebook?.name #,  Meteor.user().profile.name
        , Meteor.user().hits
    unless to? and from?
      throw new Meteor.Error 2, "to or from is missing "+from+' '+to
      return 'nothing'
    if Meteor.user()?.services?.facebook?.id?
      p1 = "http://graph.facebook.com/v2.7/"
      facebookId = Meteor.user().services.facebook.id
      p2 = "/picture?type=square"
      META.face = p1 + facebookId + p2
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
    thumbU1 = "https://api.thumbalizr.com/?url="
    thumbU2 = "&width=250&api_key="
    edge.meta.ScreenshotUrl = thumbU1+from+thumbU2+thumbalizr
    edge.meta.ScreenshotUrlTo = thumbU1+to+thumbU2+thumbalizr
    edge.author = Meteor.userId()
    edge.createdAt = time
    if Meteor.user()?.profile?.name?
      username = Meteor.user().profile.name
    else
      username = 'EarlyBird'
    setEdgeIn = {}
    setEdgeOut = {}
    setEdgeIn['out.' + FROM + '.' + username] = edge
    setEdgeIn['link.from.' + FROM + '.' + username] = edge
    edge.title = META.title# or TO # because we're in TO this
    setEdgeIn.title = edge.title
    edge.title = META.title or FROM # because we're out FROM this
    setEdgeOut['in.' + TO + '.' + username] = edge
    setEdgeOut['link.to.' + TO + '.' + username] = edge
    setEdgeOut.title = edge.title

    setIt = {}
    setIt.edited = time
    if from not in categoryTypes
      setIt.fromLast = from
    if to not in categoryTypes
      setIt.toLast = to
    setIt['in.'+FROM+'.'+TO] = edge
    setIt['link.from.'+FROM+'.'+TO] = edge
    setIt['link.to.'+TO+'.'+FROM] = edge
    # totally kills latency compensation on page
    # load to avoid uncaught error in fast render
    #if Meteor.isClient
    if UserHandle?
      if UserHandle.ready()
        subReady = true
    else subReady = false
    console.log subReady
    if Meteor.isServer or subReady
      if META.weight > -1
        Meteor.users.update # we need to know what our last connection was
          _id: Meteor.userId()
        ,
          $set: setIt
          $inc:
            'hits': 1
      else
        # if it's irrelevant, show this in the Bookmarks
        # so that the ui doesn't add them to the dropdown
        # TODO how can it be possible to have duplicate entries
        # in dropdown? are we sure they are unioque urls?
        # TODO break out model operations into tested functions
        # get my bookmarka, get a title for this place, etc
        setIt['out.Bookmarks.'+FROM+'.meta.weight'] = 0
        Meteor.users.update # we need to know what our last connection was
          _id: Meteor.userId()
        ,
          $set: setIt
          $inc:
            'hits': 1
    if Meteor.isClient
      Meteor.call 'GroundedUserInsert'
    Meteor.call 'secondaryLinking',
      FROM: FROM
      TO: TO
      edge: edge
      setEdgeOut: setEdgeOut
      setEdgeIn: setEdgeIn
  migrateLinks: ->
    user = Meteor.user()
    old =
      in: user.in
      out: user.out
    levelOne = (direction,bundle) ->
      levelTwo(direction, bundle, url, urlBundle) for url, urlBundle of bundle
    levelTwo = (direction,bundle, url, urlBundle) ->
      levelThree(direction,bundle, url, urlBundle,urlBundleKey,urlBundleObject) for urlBundleKey, urlBundleObject of urlBundle
    levelThree = (direction,bundle, url, urlBundle,urlBundleKey,urlBundleObject) ->
      console.log direction
      , Object.keys(bundle).length
      #, url
      , Object.keys(urlBundle).length
      #, urlBundleKey
      #, urlBundleObject
      , urlBundleObject.meta.title
      if Meteor.isServer
        Meteor.call 'Linking',
          from: urlBundleObject.meta.FromLink
          to: urlBundleObject.meta.ToLink
          meta:
            body: urlBundleObject.meta.body
            weight: urlBundleObject.meta.weight
            title: urlBundleObject.meta.title
    levelOne(direction,bundle) for direction, bundle of old


  checkHits: ->
    if Meteor.isServer
      hits = Meteor.user().hits
      fbnameExists = Meteor.user()?.services?.facebook?.name?
      if fbnameExists
        name = Meteor.user().services.facebook.name
      console.log 'Meteor.user().hits', hits, 'checkHits server', name
      return hits

  secondaryLinking: (payload) ->
    #if Meteor.isServer
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
    console.log 'Just setupUser', Meteor.user().hits, Meteor.user()._id

    Meteor.call "Linking",
      from: 'Bookmarks'
      to: 'Bookmarks' # the thing we're defining
      meta:
        title: 'Bookmarks'
        weight: 9
    , (error, result) ->
      if error
        new Meteor.Error 7
        , "Reply Does the User object have facebook credentials?"
    Meteor.call "Linking",
      from: linkstate.store('Linkstates.youiest.com')
      to: 'Bookmarks' # the thing we're defining
      meta:
        title: 'Linkstates - Connecting is seeing'
    , (error, result) ->
      if error
        new Meteor.Error 7
        , "Reply Does the User object have facebook credentials?"
    if Meteor.user()?.services?.facebook?.link?
      Meteor.call "Linking",
        from: Meteor.user().services.facebook.link
        to: 'Bookmarks'
        meta:
          title: Meteor.user().services.facebook.name+' on Facebook'
          weight: 7
    else
      new Meteor.Error 22, "non facebook user tried to login"
  compareHits: ->
    if Meteor.isClient
      Meteor.call "checkHits", (error, result) ->
        if error
          console.log "error", error
        if result
          unless result is Meteor.user().hits
            new Meteor.Error 16, "sync error? looks like user object not synced"
          localStorage.setItem 'serverHits', result
  resetUser: () ->
    if Meteor.isClient
      console.log 'remove localStorage'
      localStorage.removeItem('latest')
    else
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
          toLast: ''
          toCreated: ''
          fromCreated: ''
          thumbalizr: ''
          link: ''
      Meteor.call "setupUser"
  resetN: (node) ->
    if Meteor.user().services.facebook.id = "10154232419354595"
      console.log 'try to cleanup db', Nodes.findOne(node)._id
      Nodes.update
        _id: node
      ,
        $unset:
          in: ''
          out: ''

  #defines naming conventions for categoryTypes
