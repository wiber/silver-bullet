React = require 'react'
Slider = require('material-ui/lib/Slider').default

exports.Slider = React.createClass
  getInitialState: ->
    step: this.props.step || 0

  onChangeOpinion: (event, value) ->
    this.setState({step: value})

  render: ->
    onChangeOpinion = this.onChangeOpinion.bind(this)
    div
      className: 'slider'
      React.createElement Slider, {
        min: 0,
        max: 9,
        step: 1,
        defaultValue: this.state.step,
        onChange: onChangeOpinion
      }
      "Your opinion is " +this.state.step

