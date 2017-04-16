{changeQueryParams} = require('../changeQueryParams.coffee')

# need to parse node for whole node object...
# go to a clicked N .
# we need to add it to our bookmarks if it doesn't exist
GoMark = (place) ->
  #console.log place.N.in.Bookmarks#[linkstate.store url],place.N[direction]
  for type, url of place.type
    # is from or to url bookmarked?
    notBookmarked = !place.user?.out?.Bookmarks?[linkstate.store url]?
    if notBookmarked and url?
      title = place.N.in.Bookmarks[linkstate.sortByKeysTime(place.N.in.Bookmarks)[0]].meta.title
      console.log url, place.user.out.Bookmarks, linkstate.store(url), title, type, place, place.user.out.Bookmarks[linkstate.store(url)]
      for direction in ['in','out']
        console.log direction, place.N[direction+'.'+linkstate.store(url)], place.N[direction]
      payload =
        from: linkstate.store url
        to: 'Bookmarks'
        meta:
          weight: 5
          title: title
      Meteor.call 'Linking', payload
      #console.log payload, place.user.out.Bookmarks[linkstate.store url]
      changeQueryParams type, url
      console.log FlowRouter.getQueryParam type

exports.GoMark = GoMark
