
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
      ##console.log 'now identity ','user' + testNumber, Meteor.userId()
      Meteor.call 'Linking', FROM, TO, META, (res, err) ->
        # go the the place we just linked to
        Meteor.call "Here", TO, (error, result) ->
          # now located on linkedinProfileN
          if error
            console.log "error", error
          if result
            # linkedinProfile6.in.article6.user6.from.article6
            # this shows allows the double reference to article6 by design
            # one could update only do META there to save bandwidth.
            # but prejoins are expected to save the db more and it's only small fields
            test.equal result.in[FROM][username].from, FROM
            test.equal result.in[FROM][username].meta, META
            Meteor.logout ->
          next()
