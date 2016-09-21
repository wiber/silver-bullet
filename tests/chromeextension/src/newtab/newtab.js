websiteURL = "http://localhost:3000/"
chrome.storage.sync.get("last", function(lastPlace) {
    lastPlace = lastPlace.last
    console.log("before", lastPlace);

    function toQueryString(obj) {
        var parts = [];
        for (var i in obj) {
            if (obj.hasOwnProperty(i)) {
                // one way to handle router error on () and other unencoded chars
                //spec = obj[i].replace(/\W/g,' ')
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
        //qp.replace('(','').replace(')','')
    src = websiteURL + 'about?' + qp
    console.log("queryParams", queryParams, src);
    iFrame = document.getElementById('linkstateframe')
        //iFrame.src = websiteURL + "about?from=" + encoded + "&lastTitle=" + encodedTitle
    iFrame.src = src
});
