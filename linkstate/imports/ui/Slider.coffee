React = require 'react'
Slider = require('material-ui/lib/Slider').default

exports.Slider = React.createClass
  getInitialState: ->
    step: this.props.step || 0

  onChangeWeight: (event, value) ->
    this.setState({step: value})
    if this.props.onChangeWeight
      this.props.onChangeWeight(event, value)

  render: ->
    onChangeWeight = this.onChangeWeight.bind(this)
    div
      className: 'xyz'
      React.createElement Slider, {
        min: 0,
        max: 9,
        step: 1,
        defaultValue: this.state.step,
        onChange: onChangeWeight
      }
      "Your weight is " +this.state.step

