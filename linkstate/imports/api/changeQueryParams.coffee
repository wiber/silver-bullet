exports.changeQueryParams = (key,value) ->
  if typeof FlowRouter.setQueryParams is 'function'
    newQueryParams = {}
    newQueryParams[key] = value
    FlowRouter.setQueryParams newQueryParams
