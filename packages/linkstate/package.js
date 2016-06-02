Package.describe({
  name: 'youiest:linkstate',
  version: '0.0.2',
  // Brief, one-line summary of the package.
  summary: 'Linkstates of the web - State a link in the Hashrepublic',
  // URL to the Git repository containing the source code for this package.
  git: 'https://github.com/wiber/retap',
  // By default, Meteor will default to using README.md for documentation.
  // To avoid submitting documentation, set this field to null.
  documentation: 'README.md'
});

Package.onUse( function ( api ) {
  api.versionsFrom( '1.2.1' );
  api.use( [ 'ecmascript', 'mongo', 'accounts-base', 'coffeescript'] );
  //api.use('ground:db@0.3.14')
  api.use('tracker')
  api.use('underscore')
  api.addFiles(['lib/jsUrl.js'],['client','server']);
  api.addFiles( [ 'lib/collections.coffee', 'lib/methods.coffee' ] ,['client','server']);
  api.addFiles( [ 'lib/publish.coffee' ], [ 'server' ] );
  api.addFiles( [ 'lib/subscribe.coffee' ], [ 'client' ] );
  api.addFiles( [ 'lib/stringent.coffee' ], [ 'client' , 'server'] );

  api.export( [ "Linking", "Here", "Nodes", "Edges",'jsUrl','linkstate' ], [ 'client', 'server' ] );
} );

Package.onTest( function ( api ) {
  api.use( [ 'ecmascript', 'tinytest', 'aldeed:console-me', 'tracker', 'accounts-password', 'mizzao:accounts-testing', 'coffeescript','underscore' ,'youiest:linkstate' ] );
  api.imply([ 'tinytest', 'aldeed:console-me', 'tracker', 'accounts-password', 'mizzao:accounts-testing', 'youiest:linkstate' ] )
  api.export( [ "Linking", "Here", "Nodes", "Edges" ], [ 'client', 'server' ] );
  api.addFiles( 'tests/linkstate-tests.coffee' );
} );
