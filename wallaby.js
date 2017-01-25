module.exports = function (w) {

  return {
    files: [
      'linkstate/imports/*Browser.coffee'
    ],

    tests: [
      'linkstate/tests/*BrowserSpec.coffee'
    ]

    // CoffeeScript compiler is on by default with default options,
    // you can configure built-in compiler by passing options to it
    //compilers: {
    //  '**/*.coffee': w.compilers.coffeeScript({})
    //}
  };
};
