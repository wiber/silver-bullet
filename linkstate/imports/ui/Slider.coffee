React = require 'react'
Slider = require('material-ui/lib/Slider').default


exports.Slider = React.createClass
  onChangeWeight: (event, value) ->
    this.setState({weight: value})
    if this.props.onChangeWeight
      this.props.onChangeWeight(event, value)
  render: ->
    onChangeWeight = this.onChangeWeight.bind(this)
    div
      className: 'xyz'
      React.createElement Slider, {
        style:
          inert: "true"
          tabIndex: -1
        onFocus: () ->
          window.textAbout.refs.MainCardTextInput.focus()
        min: 0,
        max: 9,
        step: 1,
        defaultValue: @props.weight#this.state.weight,
        onChange: onChangeWeight
        value: @props.weight
        valueLabelDisplay: "on"
        ariaLabelledby: "discrete-slider-always"
        #valueLabelDisplay: @showThisAlways # "Your weight is " +this.state.weight
      }
      #{}"Your weight is " +this.state.weight
