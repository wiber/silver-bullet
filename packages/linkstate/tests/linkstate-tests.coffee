
runTests = () ->
  testNumber = 0
  testNumber+= 1
  Tinytest.addAsync testNumber+' reset db to 0', (test, next) ->
    Meteor.call "resetss", (error, result) ->
      test.length Nodes.find().fetch(), 0
      test.length Edges.find().fetch(), 0
      test.length Meteor.users.find().fetch(), 0
      next()

  testNumber+= 1
  Tinytest.addAsync testNumber+' Node.to equals TO ) Meteor.call(\'Linking\', FROM, TO, META) ', (test, next) ->
    testNumber+= 1
    FROM = 'article' + testNumber
    TO = 'linkedinProfile' + testNumber
    META = {}
    Meteor.insecureUserLogin 'user' + testNumber, (res, err) ->
      #console.log 'now idenity ','user' + testNumber, Meteor.userId()
      Meteor.call 'Linking', FROM, TO, META, (res, err) ->
    # recheck when sync'd data arrives, better ideas?
      Tracker.autorun (computation) ->
        if Edges.findOne(to: TO)
          test.equal Edges.findOne(to: TO).to, TO
          test.equal Edges.findOne(from: FROM).from, FROM
          Meteor.logout ->
            computation.stop()
            next()

  testNumber+= 1
  Tinytest.addAsync testNumber+' Meteor.call("Here", TO ) returns result.in[FROM].from incoming link correct data', (test, next) ->
    testNumber+= 1
    FROM = 'article' + testNumber
    TO = 'linkedinProfile' + testNumber
    META = 'comment body'
    username = 'user' + testNumber
    Meteor.insecureUserLogin username, (res, err) ->
      #console.log 'now identity ','user' + testNumber, Meteor.userId()
      Meteor.call 'Linking', FROM, TO, META, (res, err) ->
        # go the the place we just linked to
        Meteor.call "Here", TO, (error, result) ->
          # now located on linkedinProfileN
          if error
            #console.log "error", error
          if result
            # linkedinProfile6.in.article6.user6.from.article6
            # this shows allows the double reference to article6 by design
            # one could update only do META there to save bandwidth.
            # but prejoins are expected to save the db more and it's only small fields
            test.equal result.in[FROM][username].from, FROM
            test.equal result.in[FROM][username].meta, META
            Meteor.logout ->
          next()

  ###testNumber+= 1
  Tinytest.addAsync testNumber+' re-publish locations', (test, next) ->
    testNumber+= 1
    FROM = 'article' + testNumber
    TO = 'linkedinProfile' + testNumber
    META = {}
    Meteor.insecureUserLogin 'user' + testNumber, (res, err) ->
      #console.log 'now idenity '
      ,'user' + testNumber
      , Meteor.userId()
      , Meteor.users.findOne(Meteor.userId())
      Meteor.call 'Linking', FROM, TO, META, (res, err) ->
        Meteor.call "Here", TO, (error, result) ->
    Tracker.autorun (computation) ->
      unless !Nodes.findOne(_id: TO)
        # when linking TO, does it create a Node with the incomming link FROM
        # and subscribes to it, not just returns it..
        # here should be handled by a flow-router package
        test.equal Object.keys(Nodes.findOne(_id: TO).in)[0], FROM
        Meteor.logout ->
          computation.stop()
          next()###
Meteor.startup ->
  if Meteor.isClient
    ConsoleMe.subscribe()
    runTests()

  else
    ConsoleMe.enabled = true
    #truncateLogs()
    Meteor.users.allow insert: ->
      true
    Meteor.users.allow remove: ->
      true
    Meteor.users.allow update: ->
      true
    truncateLogs()

Meteor.methods resetss: () ->
  if Meteor.isClient

  else
    Meteor.users.remove {}
    Edges.remove {}
    Nodes.remove {}
    #l = Nodes.find().fetch().length
    ##console.log(Nodes.find().fetch().length)
    -> true

# so that logs start clean on each startup, easily see where you are
truncateLogs = ->
  spawn = Npm.require('child_process').spawn
  grep = spawn('grep')
  grep.on 'close', (code, signal) ->
    #console.log ' child process terminated due to receipt of signal ' + signal
    fs = Npm.require('fs')
    appRoot = process.env.PWD
    logPath = '/logs/all.log'
    firstPartIndex = appRoot.lastIndexOf '/'
    firstPart = appRoot.substring 0, firstPartIndex
    #console.log firstPart , 'linkstate firstPart where logs directory should', firstPart+logPath
    webl = fs.truncate(appRoot + logPath, 0, ->
      #console.log ' done overwriting the ' + firstPart+logPath
      return
    )
    return
  # send SIGHUP to process
  grep.kill 'SIGHUP'
  return

  runningOurselves = () ->
    packageName = _.find(Object.keys(Package), (p) ->
      p.search(/local-test/) > -1
    ).replace('local-test:', '')
    #console.log packageName,'running next?',packageName.indexOf("linkstate") isnt -1
    runningOurselves = packageName.indexOf("linkstate") isnt -1
    if runningOurselves
      runTests()
      runTests2()
    return runningOurselves
