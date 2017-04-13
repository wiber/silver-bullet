exports.changeQueryParams = (key,value) ->
  if typeof FlowRouter.setQueryParams is 'function'
    newQueryParams = {}
    newQueryParams[key] = value
    if key is 'from'
      if FlowRouter.getQueryParam('from') != value
        exports.changeQueryParams('switched','true')
    if FlowRouter.getQueryParam(key) is value
      # else we break back button with non moves
      return
    else
      FlowRouter.setQueryParams newQueryParams
