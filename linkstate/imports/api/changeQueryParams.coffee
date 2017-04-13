exports.changeQueryParams = (key,value) ->
  if typeof FlowRouter.setQueryParams is 'function'
    newQueryParams = {}
    newQueryParams[key] = value
    if key is 'from'
      console.log 'switching place',FlowRouter.getQueryParam('from'), value, FlowRouter.getQueryParam('from') != value
      if FlowRouter.getQueryParam('from') != value
        console.log 'we should call this function again..'
        exports.changeQueryParams('content','')
    console.log FlowRouter.getQueryParam 'content'
    FlowRouter.setQueryParams newQueryParams
