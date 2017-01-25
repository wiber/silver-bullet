oneSteps = function ( url ,title) {
  // we simply need to know what page we were on when ctrl t or ctrl n was pressed
  if ( url == "chrome://newtab/" ) {
    //console.log( "chrome://newtab/" );
  } else {
    //console.log( url );
    chrome.storage.sync.set( {
      'last': {
          'url': url,
          'title': title
      }
    } )
  }
}

chrome.tabs.onHighlighted.addListener( function ( highlightInfo ) {
  chrome.tabs.get( highlightInfo.tabIds[ 0 ], function ( tab ) {
    //var title = document.getElementsByTagName("title")[0].innerHTML;
    //console.log(title);
    //console.log(tab.title);
    oneSteps( tab.url , tab.title)
  } )
} );

chrome.windows.onFocusChanged.addListener( function ( windowId ) {
  if ( windowId == 'WINDOW_ID_NONE' ) {
    //console.log( windowId, 'WINDOW_ID_NONE' );
  } else {
    //console.log( windowId );
  }
} )
