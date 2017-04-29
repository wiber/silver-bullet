page = {}
lastTab = {}
chrome.runtime.onMessage.addListener(
  function(request, sender, sendResponse) {
    console.log(sender.tab ?
                "from a content script:" + sender.tab.url :
                "from the extension");
    if (request.greeting == "hello")
      console.log('sending message',page,lastTab);
      sendResponse({farewell: page});
  });

oneSteps = function ( url ,title) {
  // we simply need to know what page we were on when ctrl t or ctrl n was pressed
  if ( url == "chrome://newtab/" ) {
    //console.log( "chrome://newtab/" );
  } else {
    console.log( url, title );
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
    lastTab = tab
    console.log('onHighlighted',tab.title);
    oneSteps( tab.url , tab.title)
  } )
} );

chrome.tabs.onUpdated.addListener( function ( tabId, changeInfo, tab ) {

  if (tab.id == lastTab.id) {
    console.log('this tab was highlighted last',tab.title,tab);
    oneSteps( tab.url , tab.title);
  } else {
    //console.log('onUpdated but not last highlighted',tab.title,tab);
  }

} );
