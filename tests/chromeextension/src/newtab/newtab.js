websiteURL = "http://localhost:3000/"
chrome.storage.sync.get("last", function(lastPlace) {
    lastPlace = lastPlace.last
    console.log("before", lastPlace);
    function toQueryString(obj) {
        var parts = [];
        for (var i in obj) {
            if (obj.hasOwnProperty(i)) {
                parts.push(encodeURIComponent(i) + "=" + encodeURIComponent(obj[i].replace(/\W/g,'_')));
            }
        }
        return parts.join("&");
    }
    queryParams = {}
    queryParams.from = lastPlace.url
    queryParams.lastTitle = lastPlace.title
    qp = toQueryString(queryParams)
    qp.replace('(','').replace(')','')
    src = websiteURL + 'about?' + qp
    console.log("queryParams", queryParams, src);
    iFrame = document.getElementById('linkstateframe')
        //iFrame.src = websiteURL + "about?from=" + encoded + "&lastTitle=" + encodedTitle
    iFrame.src = src
});
