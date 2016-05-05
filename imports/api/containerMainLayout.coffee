reactKup = require('react-kup')
React = require('react')

MuiThemeProvider = require('material-ui/lib/MuiThemeProvider.js').default
{lightBaseUsTheme} = require('../ui/theme.coffee')
#require('react-select/dist/react-select.css') # 1.3.2 but here just include file
# require('../ui/cssimport.js') # unexpected token so putting it in root
#{Selected} = require('../ui/selected.coffee') # not maintained
MainLayout = React.createClass
  getDefaultProps: ->
    #expandMainCard: true
  componentDidMount: ->
  render: ->
    that = this
    reactKup (k) ->
      k.build MuiThemeProvider,
        muiTheme: lightBaseUsTheme
        ->
          k.div
            className: 'onlyOne'
            ->
              k.div 'header'
              k.div
                className: 'main'
                ->
                  k.build MainCard, # need comma here because the second arg is prop
                    expanded: that.props.expandMainCard
                    to: that.props.to
                    from: that.props.from
              k.div 'footer'


CardActions = require 'material-ui/lib/card/card-actions'
CardHeader = require 'material-ui/lib/card/card-header'
FlatButton = require 'material-ui/lib/flat-button'
CardText = require 'material-ui/lib/card/card-text'
Card = require 'material-ui/lib/card/card'

Select = require('react-select')
SimpleSelect = require("react-selectize").SimpleSelect
#require('node_modules/react-selectize/themes/index.css')

ReactDOM = require('react-dom')
changeQueryParams = require('./changeQueryParams.coffee').changeQueryParams
Selected = React.createClass
  propTypes: (props) ->
    from: React.propTypes.string
    to: React.propTypes.string
    type: React.propTypes.string
    options: React.propTypes.array
  queryParamChange: (val) ->
    if val.value
      changeQueryParams @props.type, val.value
  render: ->
    that = this
    window[that.props.type] = this
    reactKup (k) ->
      k.build SimpleSelect,
        maxValues: 1
        style:
          overflow: 'hidden'
          display: 'inline-block'
          #textOverflow: "ellipsis"
          whiteSpace: "nowrap"
          maxWidth: '25%' #150
        theme: "material"# // can be one of "default" | "bootstrap3" | "material" | ...
        transitionEnter: true
        onValueChange: that.queryParamChange
        defaultValue: _.find(that.props.options, (obj) ->
          obj.value == that.props[that.props.type]
        )
        ref: that.props.type
        id: that.props.type
        options: that.props.options
        tabIndex: if that.props.type is 'from' then '2' else '3'
        tether: !!window #true # else ssr error
        hideResetButton: true
        renderValue: (item) ->
          reactKup (k) ->
            k.div
              style:
                overflow: "hidden"
                display: 'inline-block'
                textOverflow: "ellipsis"
                whiteSpace: "nowrap"
                maxWidth:  0.15 * window.innerWidth  #+'px' #'50%' #125
              item.label

{createContainer} = require 'meteor/react-meteor-data'
selectedContainer = createContainer ((props) ->
  {
    from: props.from
    to: props.to
    type: props.type
    options: [
      {
        value: 'here'
        label: 'Here'
      }
      {
        value: 'there'
        label: 'There'
      }
      {
        value: 'therethere  '
        label: 'ThereThereThereThereThereThereThereThereThereThereThereThere'
      }
    ]
  }
), Selected

containerMainLayout = createContainer ((props) ->
  {
    #from: props.from # one arg?
    #to: props.to
    #expandMainCard: props.expandMainCard # all props
  }
), MainLayout

Card = require('material-ui/lib/card/card').default
CardActions = require('material-ui/lib/card/card-actions' ).default
CardHeader = require('material-ui/lib/card/card-header').default
CardMedia = require('material-ui/lib/card/card-media').default
CardTitle = require('material-ui/lib/card/card-title').default
FlatButton = require('material-ui/lib/flat-button' ).default
CardText =  require('material-ui/lib/card/card-text').default
Toggle = require('material-ui/lib/toggle').default

MainCard = React.createClass
  getDefaultProps: ->
    expanded: false
  handleToggle: (e) ->
    if e.target == e.currentTarget
      console.log !@props.expanded, 'targeted'
    changeQueryParams 'expandMainCard', !@props.expanded
  render: ->
    that = this
    reactKup (k) ->
      k.build Card,
        expanded: that.props.expanded
        style:
          height: 'auto'
        ->
          k.build CardHeader,
            title: "URL Avatar"
            #actAsExpander: true
            showExpandableButton: true
            subtitle: "Subtitle"
            onClick: that.handleToggle
          k.build CardText,
            style:
              height: 'auto'
            -> k.build FromToSense,
              from: that.props.from
              to: that.props.to
          k.build CardText,
            expandable: true
            ->
              k.span that.props.from, ' '
              k.span that.props.to
          k.build CardActions,
            -> # return innerhtml, tags on here before
              k.build FlatButton,
                style:
                  height: 0
                label: 'Tab here to go back to "From"'
                onFocus: () ->
                  window.from.refs.from.focus()

TextField = require('material-ui/lib/TextField').default
FromToSense = React.createClass
  render: ->
    that = this
    reactKup (k) ->
      k.div ->
        k.build selectedContainer,
          from: that.props.from
          to: that.props.to
          type: 'from'
        k.build TextField,
          style:
            width: '45%'
            tabIndex: 0
            paddingLeft: 4
            marginRight: 7
            bottom: 9
          floatingLabelText: "is like ... to"
          hintText: "say something to connect them"
        k.build selectedContainer,
          to: that.props.to
          from: that.props.from
          type: 'to'

# distill down how this place fits into the world
# who and what is behind it pushing or in front of it pulling
# or the opposite directions, valence and intesity
aboutnessSubtitle = React.createClass
  render: ->
    that = this
    reactKup(k) ->
      k.span that.props.from
aboutnessHere = React.createClass
  render: ->
    that = this
    reactKup(k) ->
      k.build Card,
        expanded: that.props.expanded
        style:
          height: 'auto'
        ->
          k.build CardHeader,
            title: "About This Place"
            subtitle: that.props.from
          k.build CardText,
            style:
              height: 'auto'
            ->
              k.build Toggle,
                toggled: that.props.expanded
                onToggle: that.handleToggle
                labelPosition: 'left'
                label: 'old togg'
              k.build FromToSense,
                from: that.props.from
                to: that.props.todo
exports.containerMainLayout = containerMainLayout
