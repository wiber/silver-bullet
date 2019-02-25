exports.changeQueryParams = (key,value) ->
  if typeof FlowRouter.setQueryParams is 'function'
    newQueryParams = {}
    newQueryParams[key] = value
    from = key is 'from'
    to = key is 'to'
    if key is 'from' #or key is 'to'
      if FlowRouter.getQueryParam(key) != value
        exports.changeQueryParams('switched','true')
    if FlowRouter.getQueryParam(key) is value
      return
    else
      FlowRouter.setQueryParams newQueryParams

exports.changeQueryParamsObject = (changes) ->
  for key, value of changes
    exports.changeQueryParams key, value
