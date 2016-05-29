// serviceconfiguration.js
Meteor.startup(function(){
    ServiceConfiguration.configurations.upsert( {
      service: "facebook"
    }, {
      $set: {
        appId: "930010317052603",
        secret: "929bcc54d1562a615a5ae8c03b4d570a"
      }
    } );
});
