websiteURL = "http://linkstate.youiest.com/about?"

console.log(websiteURL);
frameit = function(lastPlace) {
    lastPlace = lastPlace.last
    console.log("before", lastPlace);
    function toQueryString(obj) {
        var parts = [];
        for (var i in obj) {
            if (obj.hasOwnProperty(i)) {
                // flowrouter-ssr cannot handle '()' which often appears in titles
                spec = obj[i].replace(/[\-_.!~*'()]/g,"_")//.replace('(', '+').replace(')', '+')
                console.log(spec);
                parts.push(encodeURIComponent(i) + "=" + encodeURIComponent(spec));
            }
        }
        return parts.join("&");
    }
    queryParams = {}
    queryParams.from = lastPlace.url
    queryParams.lastTitle = lastPlace.title//.replace(/[\-_.!~*'()]/g,"_")
    qp = toQueryString(queryParams)
    src = websiteURL + qp
    console.log("queryParams", queryParams, src);
    iFrame = document.getElementById('linkstateframe')
    iFrame.src = src
    console.log(document.getElementById('linkstateframe').src, 'set src');
}

chrome.runtime.sendMessage({greeting: "hello"}, function(response) {
  console.log(response.farewell && response.farewell.last, response.farewell, response.farewell.last);
  if(response.farewell && response.farewell.last){
    console.log('got response', response.farewell);
    frameit(response.farewell)
  } else {
    console.log('no response, from storage instead');
    chrome.storage.sync.get("last", frameit);
  }

});
