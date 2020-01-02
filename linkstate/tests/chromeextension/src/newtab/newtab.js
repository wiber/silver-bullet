websiteURL = "http://localhost:3000/about?"
window.background = chrome.extension.getBackgroundPage(); //do this in global scope for popup.js
console.log(background.websiteURL);
console.log(background.background);
console.log(window.background.pageTabStep);
try {
  console.log(window.background.page.last, window.background.page.last.title)
} catch (e) {

} finally {

}

frameit = function(lastPlace) {
    lastPlace = lastPlace.last
    function toQueryString(obj) {
        var parts = [];
        for (var i in obj) {
            if (obj.hasOwnProperty(i)) {
                // flowrouter-ssr cannot handle '()' which often appears in titles
                spec = obj[i]//.replace('(', '\x28').replace(')', '\x29')//.replace(/[\-_.!~*'()]/g,"_")//
                // watch out for the need to unesacape serverside, so far looks good
                parts.push(escape(encodeURIComponent(i)) + "=" + escape(encodeURIComponent(spec)));
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
}

chrome.runtime.sendMessage({greeting: "hello"}, function(response) {
  backroundPageUrl = window.background.page.last.url
  console.log({backroundPageUrl});
  console.log({response});
  if(response.farewell && response.farewell.last){
    console.log('got response', response.farewell);
    frameit(response.farewell)
  } else {
    console.log('no response, from storage instead');
    chrome.storage.sync.get("last", frameit);
  }

});
/*
chrome.runtime.sendMessage({greeting: "tab"}, function(response) {
  if(response.tab && response.tab.title){
    console.log('got response', response.farewell);
    frameit({
      from: response.tab.url,
      lastTitle: response.tab.title
    })
  } else {
    console.log('no response, from storage instead');
    chrome.storage.sync.get("last", frameit);
  }

});
*/
