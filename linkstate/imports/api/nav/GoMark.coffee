{changeQueryParams} = require('../changeQueryParams.coffee')

# need to parse node for whole node object...
# go to a clicked N .
# we need to add it to our bookmarks if it doesn't exist
GoMark = (place) ->
  #console.log place.N.in.Bookmarks#[linkstate.store url],place.N[direction]
  for type, url of place.type
    # is from or to url bookmarked?
    notBookmarked = !place.user?.out?.Bookmarks?[linkstate.store url]?
    if !notBookmarked
      console.log 'got url in bookmarks', url
      changeQueryParams type, url
    else
      # best we can do is show user the article they don't have.. and go through the marking
      # to do it properly, to just change qp and enable user to weigh in right away requires a slight refactor or data model

      title = place.N.in.Bookmarks[linkstate.sortByKeysTime(place.N.in.Bookmarks)[0]].meta.title
      key =
        from: 'out'
        to: 'in'
      Ndir = place.N[key[type]]
      NdirUrl = Ndir[linkstate.store url]
      payload =
        from: linkstate.store url
        to: 'Bookmarks'
        meta:
          weight: 5
          title: title
      console.log 'not have url in bookmarks', url, type, title, Ndir, NdirUrl, payload
      window.open(url,'_blank')
      #Meteor.call 'Linking', payload
      #console.log payload, place.user.out.Bookmarks[linkstate.store url]
      #changeQueryParams type, url
      #console.log payload, FlowRouter.getQueryParam type

exports.GoMark = GoMark
###
