var baseConfig = require('./karma.base.conf');

module.exports = function(config) {

  baseConfig(config);

  config.set({
    files: [
      'bower_components/angularjs/angular.js',
      'bower_components/angular-mocks/angular-mocks.js',
      'src/*.coffee',
      'test/formGroupStandaloneSpec.coffee'
    ]
  });
};