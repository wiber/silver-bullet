page = {}
lastTabHighlighted = {}
onMessageListener = function(request, sender, sendResponse) {
  console.log(sender.tab ?
              "from a content script:" + sender.tab.url :
              "from the extension");
  if (request.greeting == "hello")
    console.log('sending message',page,lastTabHighlighted);
    sendResponse({farewell: page});
}
chrome.runtime.onMessage.addListener(onMessageListener);

oneSteps = function ( url ,title) {
  if ( url == "chrome://newtab/" ) {
  } else {
    console.log('oneSteps', url, title );
    page = {
      'last': {
          'url': url,
          'title': title
      }
    }
    chrome.storage.sync.set( page )
  }
}


chrome.tabs.onHighlighted.addListener( function ( highlightInfo ) {
  chrome.tabs.get( highlightInfo.tabIds[ 0 ], function ( tab ) {
    //var title = document.getElementsByTagName("title")[0].innerHTML;
    //console.log(title);
    //console.log(tab.title);
    lastTabHighlighted = tab
    console.log('onHighlighted',tab.title);
    oneSteps( tab.url , tab.title)
  } )
} );

chrome.tabs.onUpdated.addListener( function ( tabId, changeInfo, tab ) {

  if (tab.id == lastTabHighlighted.id) {
    console.log('this tab was highlighted last',tab.title);
    oneSteps( tab.url , tab.title);
  } else {
    //console.log('onUpdated but not last highlighted',tab.title,tab);
  }

} );
