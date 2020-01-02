window.page = {}
window.lastTabHighlighted = {}
onMessageListener = function(request, sender, sendResponse) {
  console.log(sender.tab ?
              "from a content script:" + sender.tab.url :
              "from the extension");
  if (request.greeting == "hello")
    console.log('sending message',page,lastTabHighlighted);
    chrome.tabs.get( highlightInfo.tabIds[ 0 ], function ( tab ) {
      //var title = document.getElementsByTagName("title")[0].innerHTML;
      //console.log(title);
      //console.log(tab.title);
      console.log('onHighlighted pre sending message',tab,tab.title);
      lastTabHighlighted = tab
      oneSteps(tab)
    } )
    // why is this undefined? we're in some kind of non global space..
    sendResponse({farewell: window.page});
}
chrome.runtime.onMessage.addListener(onMessageListener);

oneSteps = function ( tab) {
  url = tab.url
  title =  tab.title
  if ( url == "chrome://newtab/" ) {
  } else {
    console.log( url, title );
    window.page = {
      'last': {
          'url': url,
          'title': title
      }
    }
    console.log(page,'oneSteps', page.last.title);
    try {
      console.log(chrome.storage.sync.get('last'));
    } catch (e) {

    } finally {

    }

    chrome.storage.sync.set( page )
  }
}


chrome.tabs.onHighlighted.addListener( function ( highlightInfo ) {
  chrome.tabs.get( highlightInfo.tabIds[ 0 ], function ( tab ) {
    //var title = document.getElementsByTagName("title")[0].innerHTML;
    //console.log(title);
    //console.log(tab.title);
    console.log('onHighlighted',tab,tab.title,lastTabHighlighted);
    lastTabHighlighted = tab
    oneSteps(tab)
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
