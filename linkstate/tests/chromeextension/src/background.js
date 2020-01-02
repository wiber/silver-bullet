window.page = {}
window.lastTabHighlighted = []
window.pageTabStep = {}
onMessageListener = function(request, sender, sendResponse) {
  console.log(sender.tab ?
              "from a content script:" + sender.tab.url :
              "from the extension");
  if (request.greeting == "hello")
    console.log('sending message',page,lastTabHighlighted, chrome.tabs.get);
    chrome.tabs.get( highlightInfo.tabIds[ 0 ], function ( tab ) {
      //var title = document.getElementsByTagName("title")[0].innerHTML;
      //console.log(title);
      //console.log(tab.title);
      //console.log('onHighlighted pre sending message',tab,tab.title);
      window.lastTabHighlighted.unshift(tab)
      sendResponse({farewell: tab});
      oneSteps(tab)
    } )
    // why is this undefined? we're in some kind of non global space..
    sendResponse({farewell: window.page});
}
chrome.runtime.onMessage.addListener(onMessageListener);

oneSteps = function ( tab) {
  url = tab.url
  title =  tab.title
  pendingUrl = tab.pendingUrl
  urlNT = "chrome://newtab/"
  pageTabStep = {url,title,pendingUrl}
  //console.log(page,pageTabStep,"oneSteps precondition")
  if ( url == urlNT || pendingUrl == urlNT ) {
     console.log(tab.title,'oneSteps',pageTabStep)
  } else {
    //console.log( url, title );
    // in a fit of rage as the chrome api must have been updated we now do globals
    window.page = {
      'last': {
          'url': url,
          'title': title
      }
    }

    chrome.storage.sync.set({last:page.last})

    try {
      //console.log(chrome.storage.sync.get(['last']));
    } catch (e) {
      console.log(e)
    } finally {

    }
  }
}


chrome.tabs.onHighlighted.addListener( function ( highlightInfo ) {
  chrome.tabs.get( highlightInfo.tabIds[ 0 ], function ( tab ) {
    //var title = document.getElementsByTagName("title")[0].innerHTML;
    //console.log(title);
    //console.log(tab.title);
    console.log('onHighlighted',tab,tab.title,window.lastTabHighlighted);
    //window.lastTabHighlighted.unshift(tab)
    window.lastTabHighlighted.unshift(tab)
    oneSteps(tab)
  } )
} );

chrome.tabs.onUpdated.addListener( function ( tabId, changeInfo, tab ) {

  if (tab.id == window.lastTabHighlighted.id) {
    console.log('this tab was highlighted last',tab.title);
   // oneSteps( tab.url , tab.title);
  } else {
    //console.log('onUpdated but not last highlighted',tab.title,tab);
  }

} );
