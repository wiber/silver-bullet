websiteURL = "http://localhost:4000/"
chrome.storage.sync.get( "lastStep", function ( lastPlace ) {
  encoded = encodeURIComponent(lastPlace.lastStep)
  // step is is called on newtab too, so where were we again?
  document.getElementById('linkstateframe').src = websiteURL+"about/?&from="+encoded

});
