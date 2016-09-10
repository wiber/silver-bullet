websiteURL = "http://localhost:3000/"
chrome.storage.sync.get("last", function(lastPlace) {
    lastPlace = lastPlace.last
    console.log("before",lastPlace);
//console.log(lastPlace, lastPlace.url, lastPlace.title);
    // must handle hashbangs
    // http://localhost:3000/about?from=https%3A%2F%2Fmail.google.com%2Fmail%2Fu%2F0%2F%23inbox&lastTitle=Inbox%20(4)%20-%20eliasmoosman%40gmail.com%20-%20Gmail
    //lastPlace.url.replace('0','+').replace('#','+').replace(':','+').replace(':','+')
    //encoded = encodeURIComponent(lastPlace.url)
    //encodedTitle = lastPlace.title.replace('0','+').replace('#','+').replace('(','+').replace(')','+')
//console.log("lastPlace transformed", lastPlace,encoded);
//console.log(encoded, ' is where from ', decodeURIComponent(encoded), ' lastStep', lastPlace.title, encodedTitle);
function toQueryString(obj) {
  var parts = [];
  for (var i in obj) {
      if (obj.hasOwnProperty(i)) {
          parts.push(encodeURIComponent(i) + "=" + encodeURIComponent(obj[i]));
      }
  }
  return parts.join("&");
}
    queryParams = {}
    queryParams.from = lastPlace.url
    queryParams.lastTitle = lastPlace.title
    src = websiteURL+'about?'+toQueryString(queryParams)
    console.log("queryParams", queryParams,src);

    iFrame = document.getElementById('linkstateframe')
    //iFrame.src = websiteURL + "about?from=" + encoded + "&lastTitle=" + encodedTitle
    iFrame.src = src
});
