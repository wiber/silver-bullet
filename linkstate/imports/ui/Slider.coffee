React = require 'react'
Slider = require('material-ui/lib/Slider').default


exports.Slider = React.createClass
  getInitialState: ->
    weight: this.props.weight || 0
  componentWillReceiveProps: ->
    this.setState({weight: @props.weight})
  onChangeWeight: (event, value) ->
    this.setState({weight: value})
    if this.props.onChangeWeight
      this.props.onChangeWeight(event, value)
  newWeight: (value) ->
    this.setState({weight: value})
  showThisAlways: () ->
    console.log 'metas', @props.weight
    @props.weight
  render: ->
    onChangeWeight = this.onChangeWeight.bind(this)
    div
      className: 'xyz'
      React.createElement Slider, {
        min: 0,
        max: 9,
        step: 1,
        defaultValue: this.state.weight,
        onChange: onChangeWeight
        value: @props.weight
        valueLabelDisplay: "on"
        #ariaLabelledby: "discrete-slider-always"
        #valueLabelDisplay: @showThisAlways
      }
      #{}"Your weight is " +this.state.weight
