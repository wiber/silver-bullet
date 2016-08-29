# LinkList.coffee renders a list of links ordered by weight
reactKup = require('react-kup')
React = require('react')
{style} = require('../ui/style.coffee')
{changeQueryParams} = require('../api/changeQueryParams.coffee')
Card = require('material-ui/lib/card/card').default
CardActions = require('material-ui/lib/card/card-actions' ).default
CardHeader = require('material-ui/lib/card/card-header').default
CardMedia = require('material-ui/lib/card/card-media').default
CardTitle = require('material-ui/lib/card/card-title').default
FlatButton = require('material-ui/lib/flat-button' ).default
CardText =  require('material-ui/lib/card/card-text').default
{GridList, GridTile} = require 'material-ui/lib/grid-list'
{Subheader} = require 'material-ui/lib/Subheader'
{StarBorder} = require 'material-ui/lib/svg-icons/toggle/star-border'

exports.LinkList = React.createClass
  render: ->
    that = this
    reactKup (k) ->
      k.build CardText,
        style:
          height: 'auto'
        expandable: true
        ->
          k.build GridList,
            #cellHeight: 200
            cols: 1
            ->
              if that.props?.user?.out?.Bookmarks?
                out = that.props.user.out.Bookmarks # is collection of edges..
                n = 0
                for mark in linkstate.sortByKeysTime(out, that.props.howMany)
                 #console.log out, mark
                  target = out[mark]
                  m = target.meta
                  n++
                  if n < that.props.howMany
                    k.build GridTile,
                      key: mark
                      title: m.FromLink
                      subtitle: ' => '+ m.ToLink
                      ->
                        k.img
                          style: _.extend {}, style.webShot
                          src:  "https://api.thumbalizr.com/?url="+m.FromLink+"&width=250&api_key=5VmUR42gc4eGdLjBnZH2BRXa"
