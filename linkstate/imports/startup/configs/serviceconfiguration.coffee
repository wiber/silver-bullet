# imports/startup/configs/serviceconfiguration.coffee
Meteor.startup ->
  ServiceConfiguration.configurations.upsert { service: 'facebook' }, $set:
    appId: Meteor.settings.facebookAppId
    secret: Meteor.settings.facebookSecret
    oauthSecretKey: Meteor.settings.oauthSecretKey
  return
