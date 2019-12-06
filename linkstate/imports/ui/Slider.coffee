React = require 'react'
Slider = require('material-ui/lib/Slider').default
# https://v0.material-ui.com/v0.15.0/#/components/slider

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
        onFocus: () ->
          window.to.refs.selecters.focus()
        min: 0,
        max: 9,
        step: 1,
        defaultValue: @props.weight#this.state.weight,
        onChange: onChangeWeight
        value: @props.weight
<<<<<<< HEAD
        # valueLabelDisplay: "on"
        #ariaLabelledby: "discrete-slider-always"
=======
        valueLabelDisplay: "on"
        ariaLabelledby: "discrete-slider-always"
>>>>>>> mergeDS
        #valueLabelDisplay: @showThisAlways # "Your weight is " +this.state.weight
      }
      #{}"Your weight is " +this.state.weight
