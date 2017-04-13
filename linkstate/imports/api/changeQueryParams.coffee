exports.changeQueryParams = (key,value) ->
  if typeof FlowRouter.setQueryParams is 'function'
    newQueryParams = {}
    newQueryParams[key] = value
    if key is 'from'
      if FlowRouter.getQueryParam('from') != value
        exports.changeQueryParams('switched','true')
    FlowRouter.setQueryParams newQueryParams
