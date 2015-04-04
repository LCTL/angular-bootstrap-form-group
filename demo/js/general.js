angular
  .module('app', ['bootstrap.formGroup'])
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
