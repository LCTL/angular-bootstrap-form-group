template = 
  """
    <div class="form-group {{ formGroupClass }}" ng-class="{ 'has-error': hasError && formDirty }">
      <label for="{{ for }}" ng-bind="{{ label }}" class="control-label {{ labelClass }}"></label>
      <div class="{{ transcludeClass }}">
        <div ng-transclude> </div>
        <div ng-show="formDirty" class="help-block">
          <p ng-repeat="error in errors" ng-if="error.notValid" class="text-danger" ng-bind="error.message"></p>
        </div>
      </div>
    </div>
  """

inputTagNmaes = ['input', 'select', 'textarea']

angular.module('bootstrap.formGroup', [])

  .directive 'formGroup', ['$injector', ($injector) ->

    restrict : 'AE'
    template: template
    replace: true
    transclude: true
    require: "^form"
    scope:
      label: "@"
      formGroupClass: "@"
      labelClass: "@"
      transcludeClass: "@"

    link: ($scope, element, attrs, formController) ->

      input = null

      for tagName in inputTagNmaes
        input = element.find tagName
        if input.length > 0
          break

      inputId = input.attr 'id'
      inputName = input.attr 'name'

      if inputName

        form = input.parent()
        form = form.parent() until form.prop('tagName') is 'FORM'

        formName = form.attr 'name'

        $scope.for = inputId
        $scope.form = $scope.form
      
        invalidExpression = [formName, inputName, '$invalid'].join '.'
        dirtyExpression = [formName, inputName, '$dirty'].join '.'
        errorExpression = [formName, inputName, '$error'].join '.'

        $scope.$parent.$watch invalidExpression, (hasError) ->
            
          $scope.hasError = hasError

        $scope.$parent.$watch dirtyExpression, (dirty) ->

          $scope.formDirty = dirty

        $scope.$parent.$watch errorExpression, (errors) ->

          $scope.errors = []

          for property, notValid of errors

            message = input.attr 'ng-em-' + property

            message = property if not message

            if $injector.has '$translate'

              $translate = $injector.get '$translate'

              fn = (messageKey, value, property, notValid) ->

                $translate(messageKey, value: value).then (translatedMessage) ->

                  $scope.errors.push
                    name: property
                    message: translatedMessage
                    notValid: notValid

              fn message, input.attr('ng-' + property) || input.attr(property), property, notValid

            else

              $scope.errors.push
                name: property
                message: message
                notValid: notValid

        , true

  ]