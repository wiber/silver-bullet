{changeQueryParams} = require('../api/changeQueryParams.coffee')
{createContainer} = require 'meteor/react-meteor-data'
bulletUnit = require('../ui/bulletUnit.coffee').bulletUnit

exports.bulletUnitContainer = createContainer ((props) ->

  newprops = Object.assign {}, props
  console.log 'bulletUnitContainer', newprops
  newprops
), bulletUnit
