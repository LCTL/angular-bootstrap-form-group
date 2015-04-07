var baseConfig = require('./karma.base.conf');

module.exports = function(config) {

  baseConfig(config);

  config.set({
    files: [
      'bower_components/angularjs/angular.js',
      'bower_components/angular-mocks/angular-mocks.js',
      'bower_components/angular-translate/angular-translate.js',
      'src/*.coffee',
      'test/translate-test-app.coffee',
      'test/formGroupTranslateSpec.coffee'
    ]
  });
};