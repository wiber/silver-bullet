websiteURL = "http://linkstate.youiest.com/"
console.log(websiteURL);
frameit = function(lastPlace) {
    lastPlace = lastPlace.last
    console.log("before", lastPlace);
    function toQueryString(obj) {
        var parts = [];
        for (var i in obj) {
            if (obj.hasOwnProperty(i)) {
                // flowrouter-ssr cannot handle '()' which often appears in titles
                spec = obj[i].replace('(', '+').replace(')', '+')
                console.log(spec);
                parts.push(encodeURIComponent(i) + "=" + encodeURIComponent(spec));
            }
        }
        return parts.join("&");
    }
    queryParams = {}
    queryParams.from = lastPlace.url
    queryParams.lastTitle = lastPlace.title
    qp = toQueryString(queryParams)
    src = websiteURL + 'about?' + qp
    console.log("queryParams", queryParams, src);
    iFrame = document.getElementById('linkstateframe')
    iFrame.src = src
}

chrome.runtime.sendMessage({greeting: "hello"}, function(response) {
  console.log(response.farewell);
  if(response.farewell){
    frameit(response.farewell)
  } else {
    chrome.storage.sync.get("last", frameit);
  }

});
