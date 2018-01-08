R = require('ramda')
Lo = require 'lodash'

exports.hereAndThere = (user, props) ->
  {from,to} = props
  HERE = Lo.get props, 'user.links.in.Bookmarks.' + linkstate.store(from)
  HereScreenshotUrl = Lo.get HERE, 'meta.ScreenshotUrl'
  unless HERE?
    HERE =
      title: that.props.lastTitle
      from: that.props.from
    console.log 'we are noplace', HERE
  THERE = Lo.get props, 'user.links.in.Bookmarks.' + linkstate.store(to)
  ThereScreenshotUrl = Lo.get THERE, 'meta.ScreenshotUrl'
  return {HERE, HereScreenshotUrl, THERE, ThereScreenshotUrl}
