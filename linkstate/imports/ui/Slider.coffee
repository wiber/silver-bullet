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
  render: ->
    onChangeWeight = this.onChangeWeight.bind(this)
    console.log @props.weight, 'metas not', this.state.weight
    if this.state.weight != this.props.weight
      console.log @props.weight, 'metas not same', this.state.weight
      newWeight
        value: @props.weight

    div
      className: 'xyz'
      React.createElement Slider, {
        min: 0,
        max: 9,
        step: 1,
        defaultValue: this.state.weight,
        onChange: onChangeWeight
        weight: @props.weight#this.getWeight(props.meta)
        value: @props.weight
      }
      "Your weight is " +this.state.weight
