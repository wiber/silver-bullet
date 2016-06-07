module.exports = function (w) {

  return {
    files: [
      {pattern: 'lib/require.js', instrument: false},
      {pattern: 'imports/**/*.coffee', load: false},
      {pattern: 'packages/**/*.coffee', load: false},
      {pattern: 'test/test-main.js', instrument: false}
      ,

    ],

    tests: [
     {pattern: 'tests/**/*Spec.coffee', load: false},
     {pattern: 'tests/imports/sampleSpec.coffee', load: false},

    ]

    // CoffeeScript compiler is on by default with the default options
    // You can configure the built-in compiler by passing options to it
    // compilers: {
    //  '**/*.coffee': w.compilers.coffeeScript({})
    //}
  };
};
