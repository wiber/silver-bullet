exports.changeQueryParams = (key,value) ->
  newQueryParams = {}
  newQueryParams[key] = value
  FlowRouter.setQueryParams newQueryParams
