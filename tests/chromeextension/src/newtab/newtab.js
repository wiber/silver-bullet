websiteURL = "http://localhost:3000/"
chrome.storage.sync.get( "lastStep", function ( lastPlace ) {
  encoded = encodeURIComponent(lastPlace.lastStep)
  console.log(encoded,' is where from ',decodeURIComponent(encoded));
  // step is is called on newtab too, so where were we again?
  document.getElementById('linkstateframe').src = websiteURL+"about/?&from="+encoded
});
