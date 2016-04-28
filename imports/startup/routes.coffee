
mount = require('react-mounter').mount
#containerMainLayout = require('../api/MainLayoutContainer.coffee')
FlowRouter.route '/about',
  name: 'home'
  action: (params, queryParams) ->
    mount containerMainLayout,
      from: queryParams.from
      to: queryParams.to
      expandMainCard: queryParams.expandMainCard == 'true'


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

Select = require('react-select')
SimpleSelect = require("react-selectize").SimpleSelect
#require('node_modules/react-selectize/themes/index.css')
Card = require 'material-ui/lib/card/card'

changeQueryParams = (key,value) ->
  newQueryParams = {}
  newQueryParams[key] = value
  FlowRouter.setQueryParams newQueryParams

Selected = React.createClass
  propTypes: (props) ->
    from: React.propTypes.string
    to: React.propTypes.string
    type: React.propTypes.string
    options: React.propTypes.array
  queryParamChange: (val)->
    changeQueryParams @props.type, val.value
  render: ->
    that = this
    reactKup (k) ->
      k.span
        style:
          display: 'inline-block'
          width: 'auto'
        ->
          k.build SimpleSelect,
            placeholder: "Select a fruit"
            theme: "material"# // can be one of "default" | "bootstrap3" | "material" | ...
            transitionEnter: true
            onValueChange: that.queryParamChange
            defaultValue: _.find(that.props.options, (obj) ->
              obj.value == that.props[that.props.type]
            )
            ref: that.props.type
            options: that.props.options
            tabIndex: if that.props.type is 'from' then '2' else '3'

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
      FlowRouter.setQueryParams
        expandMainCard: !@props.expanded
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
            #showExpandableButton: true
            subtitle: "Subtitle"
            -> k.build Toggle,
                style:
                  float: 'right'
                ref: 'mainToggler'
                toggled: that.props.expanded
                onToggle: that.handleToggle
                labelPosition: 'left'
                label: "This toggle controls the expanded state of the component."
          k.build CardText,
            style:
              height: 'auto'
            ->
              k.build FromToSense,
                from: that.props.from
                to: that.props.to
FromToSense = React.createClass
  render: ->
    that = this
    reactKup (k) ->
      k.span 'start', ->
        k.span 'more', ->
          k.build selectedContainer,
            from: that.props.from
            to: that.props.to
            type: 'from'
        k.span 'fires', ->
          k.build selectedContainer,
            to: that.props.to
            from: that.props.from
            type: 'to'
