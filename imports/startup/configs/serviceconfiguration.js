// imports/startup/configs/serviceconfiguration.js

// changes gitignored
Meteor.startup(function(){
    ServiceConfiguration.configurations.upsert( {
      service: "facebook"
    }, {
      $set: {
        appId: Meteor.settings.facebookAppId,
        secret: Meteor.settings.facebookSecret
      }
    } );
});
