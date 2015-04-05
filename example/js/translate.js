angular
  .module('app', ['bootstrap.formGroup', 'pascalprecht.translate'])
  .config(function($translateProvider){
    $translateProvider.preferredLanguage('en')
    $translateProvider.translations('en', {
      FORM_TITLE: 'Angular Translate Support',
      FIELD: {
        EMAIL: 'Email',
        USERNAME: 'Username',
        PASSWORD: 'Password',
        PASSWORD_CONFIRMATION: 'Password Confirmation'
      },
      VALIDATION: {
        REQUIRED: 'Please enter value',
        MIN_LENGTH: 'At least enter {{value}} characters',
        MAX_LENGTH: 'Cannot not over {{value}} characters',
        PATTERN_EMAIL: 'Please input email format',
        PATTERN_ENGLISH_AND_NUMBER_CHAR: 'Only accept A-Za-z0-9_ format',
        PASSWORD_NOT_MATCH: 'Password not match'
      },
      BUTTON: {
        SUBMIT: 'SUBMIT'
      }
    });
  })
  .controller('InputFormController', function($scope){
    $scope.user = {
      email: '',
      username: '',
      password: '',
      passwordConfirmation: ''
    };

    $scope.$watch('user.passwordConfirmation', function(newValue, oldValue){
      $scope.form.passwordConfirmation.$setValidity('PASSWORD-NOT-MATCH', newValue === $scope.user.password);
    });

  })
