websiteURL = "http://linkstate.youiest.com/about?"
window.background = chrome.extension.getBackgroundPage(); //do this in global scope for popup.js
//console.log(background.websiteURL);
//console.log(background.background);
//console.log(window.background.pageTabStep);
window.globalLast = {}
// an update might have broken the messaging api so using globals instead
try {
  console.log(window.background.page.last, window.background.page.last.title)
  globalLast.url = window.background.page.last.url
  globalLast.title = window.background.page.last.title
} catch (e) {

} finally {
  //console.log({globalLast},'not pretty but works')
}


frameit = function(lastPlace) {
    //lastPlace = lastPlace.last
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
    //console.log({lastPlace});
    try {
      queryParams = {}
      queryParams.from = lastPlace.url
      queryParams.lastTitle = lastPlace.title //.replace(/[\-_.!~*'()]/g,"_")
      qp = toQueryString(queryParams)
      src = websiteURL + qp
      //console.log("queryParams", queryParams, src, lastPlace);
      iFrame = document.getElementById('linkstateframe')
      iFrame.src = src
    } catch (e) {
      console.log(e);
    } finally {

    }

}
window.onload = function(){
  last = globalLast
  frameit(last)
}

chrome.runtime.sendMessage({greeting: "hello"}, function(response) {
  backroundPageUrl = window.background.page.last.url
  //console.log({backroundPageUrl});
  //console.log({response});
  if(response.farewell && response.farewell.last){
    console.log('got response', response.farewell);
    frameit(response.farewell)
  } else {
    console.log('no response, from storage instead');
    chrome.storage.sync.get("last", frameit);
  }
});
