websiteURL = "http://localhost:3000/"
chrome.storage.sync.get("last", function(lastPlace) {
  lastPlace =  lastPlace.last
 #console.log(lastPlace,lastPlace.url,lastPlace.title);
    encoded = encodeURIComponent(lastPlace.url)
    encodedTitle = encodeURIComponent(lastPlace.title)
   #console.log(encoded,' is where from ',decodeURIComponent(encoded),' lastStep', lastPlace.lastStep);
        // step is is called on newtab too, so where were we again?
        //console.log(websiteURL+"about?from="+encoded);
    iFrame = document.getElementById('linkstateframe')
    iFrame.src = websiteURL + "about?from=" + encoded+ "&lastTitle=" + encodedTitle
});
