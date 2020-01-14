//websiteURL = "http://localhost:3000/about?"
window.background = chrome.extension.getBackgroundPage(); //do this in global scope for popup.js
//console.log(background.websiteURL);
//console.log(background.background);
//console.log(window.background.pageTabStep);
window.globalLast = {}
window.websiteURL = websiteURL
RandomId = Math.round(Math.random()*10000000)
window.sOrigin = self.origin
// an update might have broken the messaging api so using globals instead
function onlyUnique(value, index, self) {
    return self.indexOf(value) === index;
}

try {

  console.log(window.background.page.last, window.background.page.last.title)
  globalLast.url = window.background.page.last.url
  globalLast.title = window.background.page.last.title
  console.log(window.background.lastTabHighlighted.length);
  uniqueLast = window.background.lastTabHighlighted.filter(onlyUnique)
  globalLast.lastTabHighlighted = uniqueLast.splice(1,5)
  console.log(window.background.lastTabHighlighted.length,window.background.lastTabHighlighted);
  console.log(globalLast);
} catch (e) {

} finally {
  console.log(globalLast,'not pretty but works')
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
                console.log(spec,obj[i]);
            }
        }
        return parts.join("&");
    }
    //console.log({lastPlace});
    try {
      queryParams = {}
      queryParams.from = lastPlace.url
      queryParams.lastTitle = lastPlace.title //.replace(/[\-_.!~*'()]/g,"_")
      //queryParams.RandomId = RandomId
      //queryParams.origin = window.sOrigin
      // bad way to do it
      //globalLast
      try {
        queryParams.a = globalLast.lastTabHighlighted[0].url
        queryParams.b = globalLast.lastTabHighlighted[1].url
        queryParams.c = globalLast.lastTabHighlighted[2].url
        queryParams.d = globalLast.lastTabHighlighted[3].url
        queryParams.e = globalLast.lastTabHighlighted[4].url
      } catch (e) {
        console.log(e);
      } finally {

      }

      //queryParams.lastTabHighlighted = encodeURIComponent(JSON.stringify(lastPlace.lastTabHighlighted))
      //console.log(queryParams.lastTabHighlighted);
      //queryParams.lastTabHighlighted = lastPlace.lastTabHighlighted.slice(0,15)
      //queryParams.lastTabHighlighted = window.background.lastTabHighlighted
      qp = toQueryString(queryParams)
      src = websiteURL + qp
      //console.log("queryParams", queryParams, src, lastPlace);
      iFrame = document.getElementById('linkstateframe')
      iFrame.src = src
      console.log(src.length,' should be less than 2000',queryParams,src.slice(src.length-60,src.length),src)

    } catch (e) {
      console.log(e);
    } finally {
      console.log(src)
    }

}
window.onload = function(){
  last = globalLast
  frameit(last)
  sendVars = function(){
    frame = document.getElementById('linkstateframe');
    //frame.contentWindow.postMessage({window.background.lastTabHighlighted, websiteURL});
    /* frame.contentWindow.postMessage(window.background.lastTabHighlighted, window.sOrigin);
    frame.contentWindow.postMessage(window.background.lastTabHighlighted, '*');
    frame.contentWindow.postMessage(window.background.lastTabHighlighted, '*');
    //console.log(frame,'sent ',window.background.lastTabHighlighted.length, websiteURL, window.sOrigin);
    document.getElementById('linkstateframe').contentWindow.postMessage({
      event_id: 'white_label_message',
      data: window.background.lastTabHighlighted,
      message: 'some message!'}
    , '*')
    */
    //var iframes = window.frames;
    //grab first iframe.. specify the message name? weak security..
    //window.ifrWindow = iframes[0].window;  // Here is where I get **Permision denied**
    //ifrWindow.postMessage("lastTabHighlighted",window.background.lastTabHighlighted);
    //console.log(ifrWindow,'sent tab history');
  }
  setTimeout(sendVars,500)
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
