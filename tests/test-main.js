// delaying wallaby automatic start
wallaby.delayStart();
console.log("delayStart");

requirejs.config({
  baseUrl: '/imports',
  paths: {
  },

  shim: {
    'underscore': {
      exports: '_'
    }
  }
});

require(wallaby.tests, function () {
  wallaby.start();
});
