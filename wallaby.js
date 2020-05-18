module.exports = function () {
  return {
    files: [
      { pattern: "lib/require.js", instrument: false },
      {
        pattern: "linkstate/imports/*Browser.coffee",
        instrument: false,
        load: false,
      },
      { pattern: "*/*.coffee", load: false },
      { pattern: "tests/test-main.js", instrument: false },
    ],

    tests: [
      {
        pattern: "linkstate/tests/modelOperationsNodeSpec.coffee",
        load: false,
      },
    ],

    env: {
      type: "node",
      params: {
        runner: `-r ${require.resolve("esm")}`,
      },
    },
  };
};
