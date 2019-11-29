React = require 'react'
Slider = require('material-ui/lib/Slider').default


exports.Slider = React.createClass
  getInitialState: ->
    weight: this.props.weight || 0

  onChangeWeight: (event, value) ->
    this.setState({weight: value})
    if this.props.onChangeWeight
      this.props.onChangeWeight(event, value)
  getWeight: (meta) ->
    # use from to in ModelOperations instead
    console.log meta,'metas', this.props
  render: ->
    onChangeWeight = this.onChangeWeight.bind(this)
    console.log @props.weight, 'metas'
    div
      className: 'xyz'
      React.createElement Slider, {
        min: 0,
        max: 9,
        step: 1,
        defaultValue: this.state.weight,
        onChange: onChangeWeight
        weight: props.weight#this.getWeight(props.meta)
      }
      "Your weight is " +this.state.weight
