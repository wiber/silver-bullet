# imports/startup/configs/serviceconfiguration.coffee
Meteor.startup ->
  ServiceConfiguration.configurations.upsert { service: 'facebook' },
    $set: Meteor.settings.facebook
  ServiceConfiguration.configurations.upsert { service: 'linkedin' },
    $set: Meteor.settings.linkedin
  if Meteor.isClient
    Accounts.ui.config({
      requestPermissions: {
        linkedin: ["r_emailaddress", "r_liteprofile"]
      }
    });
  return
