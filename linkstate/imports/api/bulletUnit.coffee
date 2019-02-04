{changeQueryParams} = require('../api/strings.coffee')
{createContainer} = require 'meteor/react-meteor-data'
bulletUnit = require('../ui/bulletUnit.coffee').bulletUnit

exports.bulletUnitContainer = createContainer ((props) ->

  newprops = Object.assign {}, props
  newprops
), bulletUnit
