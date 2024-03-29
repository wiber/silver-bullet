
{check} = require 'meteor/check'
#Urlbox = require('urlbox').default
Urlbox = require 'urlbox'
# Set your options
Lo = require 'lodash'
{linkstate} = require('../api/strings')
{catTree, categoryTypes} = linkstate
R = require 'ramda'
@storageEncode = (url) ->
  #r = encodeURIComponent url
  r =  toString(url).replace /\./g , '%2E'
  ##console.log r
  return r

if Meteor.settings?.public?.urlboxKey?
  @urlboxKey =  Meteor.settings.public.urlboxKey
  @urlboxSecret = Meteor.settings.urlboxSecret
else
  @urlboxKey= "FLMG5BM3XeqMGa42"

urlbox = Urlbox(Meteor.settings.public.urlboxKey, Meteor.settings.urlboxSecret)

if Meteor.settings?.public?.thumbalizr?
  @thumbalizr =  Meteor.settings.public.thumbalizr
else
  @thumbalizr= "UQ6CMod6tIkVLam271a7WdUlutEJJHTE"
allCallStack = {}
stringedCallsExist = ({from, to, meta, userid}) ->
  stringedArg = linkstate.store JSON.stringify({from, to, meta, userid})
  #console.log allCallStack?[stringedArg]? , Object.keys(allCallStack).length, allCallStack[stringedArg], allCallStack
  return true if allCallStack?[stringedArg]?
  allCallStack[stringedArg] = new Date().getTime()
  if Object.keys(allCallStack).length > 15
    allCallStack = {}
  return false
Meteor.methods
  NewQueryParams: (queryParams) ->
    if Meteor.isClient
      console.log Meteor.user(), queryParams
    queryParamsState = queryParams
    Meteor.users.update
      _id: Meteor.userId()
    ,
      $set: queryParamsState
      $inc:
        'qpUpdates': 1
  GroundedUserInsert: ->
    if Meteor.isClient and Meteor?.user()?.services?.facebook?
      localStorage.setItem 'latest', JSON.stringify(Meteor.user())
  GroundedNodeInsert: ->
    if Meteor.isClient and Meteor?.user()?.services?.facebook?
      localStorage.setItem Nodes.findOne()._id, JSON.stringify(Nodes.findOne())
  # create a ling when we navigate in the app -
  # from : me to: origin
  # answers the question - what are originating from (be)
  # the link to wikipedia on origin dictates where we now originate (from) in the app
  #= what should be in the "from" dropdown
  # that means the model (db) dictates what's on the package
  # model writes to queryParams
  # model updates page
  # we don't change queryParams to update page.. bad pattern!
  Linking: ({from, to, meta}) ->
    prevSet = Meteor.user()?.links?.in?[to]?[from]?
    userId = Meteor.userId()
    if stringedCallsExist({from, to, meta, userId})
      console.log 'returning false due to doublecall'
      doublecall =  true
      if linkstate.bookmarkExistHere Meteor.user(), from
        console.log 'yay we got bookmark'

      else
        console.log 'no bookmark here, we should proceed once - need a flag'
      return false


    META = meta
    unless META?
      META = {}
    # causes an issue when connecting from bookmarks because it doesn't have a title

    if Meteor.user()?.links?.in?.Bookmarks?[linkstate.store from]?.meta?.title?
      titleOfTarget = Meteor.user().links.in.Bookmarks[linkstate.store from].meta.title
      console.log titleOfTarget
    unless META.title?
      if titleOfTarget?
        META.title = titleOfTarget
      else
        META.title = from + ' to ' + to

    unless typeof Meteor.userId() is 'string'
      throw new Meteor.Error 1, "non-user tries to link"
      return 'nothing'
    else
      if Meteor.user()?.hits?
        console.log 'Linking'
        , prevSet
        #, to not in categoryTypes
        , Meteor.user().to
        , META.title
        , from
        , META.weight
        , to
        , Meteor.user()?.services?.facebook?.name #,  Meteor.user().profile.name
        , Meteor.user().hits
    unless to? and from?
      throw new Meteor.Error 2, "to or from is missing "+from+' '+to
      return 'nothing'
    if Meteor.user()?.services?.facebook?.id?
      p1 = "https://graph.facebook.com/v2.7/"
      facebookId = Lo.get Meteor.user(), 'services.facebook.id'
      p2 = "/picture?type=square"
      META.face = p1 + facebookId + p2
      META.profileLink = Lo.get Meteor.user(), 'services.facebook.link'
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
    #if Meteor?.settings?.urlboxSecret?
    # is server the last write and therefore the secret is included next time?
    edge.meta.ScreenshotUrl = urlbox.buildUrl
      url: from
      thumb_width: 320
      format: 'png'
      quality: 80
    edge.meta.ScreenshotUrlTo = urlbox.buildUrl
      url: to
      thumb_width: 320
      format: 'png'
      quality: 80
    console.log edge.meta, 'with url box screenshots'
    edge.author = Meteor.userId()
    edge.createdAt = time
    if Meteor.user()?.profile?.name?
      username = Meteor.user().profile.name
    else
      username = 'EarlyBird'
    setEdgeIn = {}
    setEdgeOut = {}
    #setEdgeIn['out.' + FROM + '.' + username] = edge
    setEdgeIn['links.out.' + FROM + '.' + username] = edge
    edge.title = META.title# or TO # because we're in TO this
    setEdgeIn.title = edge.title
    edge.title = META.title or FROM # because we're out FROM this
    #setEdgeOut['in.' + TO + '.' + username] = edge
    setEdgeOut['links.out.' + TO + '.' + username] = edge
    setEdgeOut.title = edge.title

    userUpdateObject = {}
    userUpdateObject.edited = time
    # we want to link on newtab but not have from and to the same..
    console.log categoryTypes,"categoryTypes"
    if categoryTypes? and from not of categoryTypes
      userUpdateObject.fromLast = from
    if to not of categoryTypes
      userUpdateObject.toLast = to
    userUpdateObject['links.out.'+FROM+'.'+TO] = edge
    userUpdateObject['links.in.'+TO+'.'+FROM] = edge
    # totally kills latency compensation on page
    # load to avoid uncaught error in fast render
    if Meteor.isServer or UserHandle?.ready()
      if META.weight > 0
        Meteor.users.update # we need to know what our last connection was
          _id: Meteor.userId()
        ,
          $set: userUpdateObject
          $inc:
            'hits': 1
      else
        # if it's irrelevant, show this in the Bookmarks
        # so that the ui doesn't add them to the dropdown
        # TODO how can it be possible to have duplicate entries
        # in dropdown? are we sure they are unioque urls?
        # TODO break out model operations into tested functions
        # get my bookmarka, get a title for this place, etc
        userUpdateObject['out.Bookmarks.'+FROM+'.meta.weight'] = 0
        Meteor.users.update # we need to know what our last connection was
          _id: Meteor.userId()
        ,
          $set: userUpdateObject
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
    Meteor.call "Linking",
      from: catTree.categoryUrls.Bookmarks
      #from: 'Bookmarks'
      #to: 'Bookmarks' # the thing we're defining
      to: catTree.categoryUrls.Bookmarks
      meta:
        title: 'Bookmarks - and other placeholders'
        weight: 9
        ScreenshotUrl: urlbox.buildUrl
          url: catTree.categoryUrls.Bookmarks
          #url: 'en.wikipedia.org/wiki/bookmark'
          thumb_width: 320
          format: 'png'
          quality: 80
    Meteor.call "Linking",
      from: 'Linkstate.youiest.com/about'
      to: catTree.categoryUrls.Bookmarks
      #to: 'Bookmarks' # the thing we're defining
      meta:
        title: 'Linkstate - Connecting is seeing'
        weight: 7
    Meteor.call "Linking",
      from: 'Linkstate.youiest.com/about' # the thing we're defining
      to: 'Linkstate.youiest.com/about'
      meta:
        title: 'Linkstate - Connecting is seeing'
        weight: 8
        body: 'The fate of bookmarks can tell us a lot about Linkstate'
    if Meteor.user()?.services?.facebook?.link?
      Meteor.call "Linking",
        from: Meteor.user().services.facebook.link
        #to: 'Bookmarks'
        to: catTree.categoryUrls.Bookmarks
        meta:
          title: Meteor.user().services.facebook.name+' on Facebook'
          weight: 7
    else
      new Meteor.Error 22, "non facebook user tried to login"
    console.log 'Just setupUser', Meteor.user().hits#, Meteor.user()._id, Meteor.user().links.out.Bookmarks, Meteor.user().links.in.Bookmarks
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
          links: ''
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
