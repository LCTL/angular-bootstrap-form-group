(function() {
  var inputTagNmaes, template;

  template = "<div class=\"form-group {{ formGroupClass }}\" ng-class=\"{ 'has-error': hasError && formDirty }\">\n  <label for=\"{{ for }}\" ng-bind=\"{{label}}\" class=\"control-label {{ labelClass }}\"></label>\n  <div class=\"{{ transcludeClass }}\">\n    <div ng-transclude> </div>\n    <div ng-show=\"formDirty\" class=\"help-block\">\n      <p ng-repeat=\"error in errors\" ng-if=\"error.notValid\" class=\"text-danger\" ng-bind=\"error.message\"></p>\n    </div>\n  </div>\n</div>";

  inputTagNmaes = ['input', 'select', 'textarea'];

  angular.module('bootstrap.formGroup', []).directive('formGroup', [
    '$injector', function($injector) {
      return {
        restrict: 'AE',
        template: template,
        replace: true,
        transclude: true,
        require: "^form",
        scope: {
          label: "@",
          formGroupClass: "@",
          labelClass: "@",
          transcludeClass: "@"
        },
        link: function($scope, element, attrs, formController) {
          var dirtyExpression, errorExpression, form, formName, input, inputId, inputName, invalidExpression, tagName, _i, _len;
          input = null;
          for (_i = 0, _len = inputTagNmaes.length; _i < _len; _i++) {
            tagName = inputTagNmaes[_i];
            input = element.find(tagName);
            if (input.length > 0) {
              break;
            }
          }
          inputId = input.attr('id');
          inputName = input.attr('name');
          if (inputName) {
            form = input.parent();
            while (form.prop('tagName') !== 'FORM') {
              form = form.parent();
            }
            formName = form.attr('name');
            $scope["for"] = inputId;
            $scope.form = $scope.form;
            invalidExpression = [formName, inputName, '$invalid'].join('.');
            dirtyExpression = [formName, inputName, '$dirty'].join('.');
            errorExpression = [formName, inputName, '$error'].join('.');
            $scope.$parent.$watch(invalidExpression, function(hasError) {
              return $scope.hasError = hasError;
            });
            $scope.$parent.$watch(dirtyExpression, function(dirty) {
              return $scope.formDirty = dirty;
            });
            return $scope.$parent.$watch(errorExpression, function(errors) {
              var $translate, fn, message, notValid, property, _results;
              $scope.errors = [];
              _results = [];
              for (property in errors) {
                notValid = errors[property];
                message = input.attr('ng-em-' + property);
                if (!message) {
                  message = property;
                }
                if ($injector.has('$translate')) {
                  $translate = $injector.get('$translate');
                  fn = function(messageKey, value, property, notValid) {
                    return $translate(messageKey, {
                      value: value
                    }).then(function(translatedMessage) {
                      return $scope.errors.push({
                        name: property,
                        message: translatedMessage,
                        notValid: notValid
                      });
                    });
                  };
                  _results.push(fn(message, input.attr('ng-' + property) || input.attr(property), property, notValid));
                } else {
                  _results.push($scope.errors.push({
                    name: property,
                    message: message,
                    notValid: notValid
                  }));
                }
              }
              return _results;
            }, true);
          }
        }
      };
    }
  ]);

}).call(this);
