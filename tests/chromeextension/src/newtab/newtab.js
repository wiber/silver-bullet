websiteURL = "http://localhost:3000/"
chrome.storage.sync.get( "lastStep", function ( lastPlace ) {
  encoded = encodeURIComponent(lastPlace.lastStep)
  console.log(encoded,' is where from ',decodeURIComponent(encoded));
  // step is is called on newtab too, so where were we again?
  document.getElementById('linkstateframe').src = websiteURL+"about?from="+encoded
  // works
  // http://localhost:3000/about?from=there&to=here&expandMainCard=false&content=asd
  // from this .js
  // http://localhost:3000/about?from=http%3A%2F%2Ffurqanzafar.github.io%2Freact-selectize%2F%23%2F%3Fcategory%3Dmulti%26example%3Ddropdown-direction
});
