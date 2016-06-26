oneSteps = function ( url ) {
  // we simply need to know what page we were on when ctrl t or ctrl n was pressed
  if ( url == "chrome://newtab/" ) {
    //console.log( "chrome://newtab/" );
  } else {
    //console.log( url );
    chrome.storage.sync.set( {
      'lastStep': url
    } )
  }
}

chrome.tabs.onHighlighted.addListener( function ( highlightInfo ) {
  chrome.tabs.get( highlightInfo.tabIds[ 0 ], function ( tab ) {
    oneSteps( tab.url )
  } )
} );

chrome.windows.onFocusChanged.addListener( function ( windowId ) {
  if ( windowId == 'WINDOW_ID_NONE' ) {
    //console.log( windowId, 'WINDOW_ID_NONE' );
  } else {
    //console.log( windowId );
  }
} )
