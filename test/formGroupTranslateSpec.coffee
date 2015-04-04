describe 'Bootstrap Form Group Directive - With Angular Translate', ->

  $injector = null
  $compile = null
  $rootScope = null

  validation = (template, value, messageKey, messageValue, htmlContainMessage) ->

    $translate = $injector.get '$translate'
    $rootScope.foo = value
    element = $compile(template)($rootScope)
    $rootScope.form.foo.$setViewValue value
    $rootScope.$digest()

    message = $translate.instant messageKey, value: messageValue

    if htmlContainMessage

      expect(element.html()).to.contain ">#{message}</p>"

    else

      expect(element.html()).not.to.contain ">#{message}</p>"

  validationFailed = (template, value, messageKey, messageValue) ->

    validation template, value, messageKey, messageValue, true

  validationOk = (template, value, messageKey, messageValue) ->

    validation template, value, messageKey, messageValue, false

  beforeEach module('app')

  beforeEach inject (_$injector_, _$compile_, _$rootScope_) ->

    $injector = _$injector_
    $compile = _$compile_
    $rootScope = _$rootScope_

    $httpBackend = $injector.get '$httpBackend'

    $httpBackend.whenGET(/.*/).passThrough()

  describe 'Angularjs init', ->

    it 'should $compile not null', ->

      expect($compile).not.to.be.null

    it 'should $rootScope not null', ->

      expect($rootScope).not.to.be.null

  describe 'Input element', ->

    describe 'input text required validation', ->

      template =
        """
          <form name="form">
            <div form-group>
              <input type="text" name="foo" ng-model="$root.foo" ng-em-required="VALIDATION.REQUIRED" required />
            </div>
          </form>
        """

      it 'should display required message when model value is empty', ->

        validationFailed template, '', 'VALIDATION.REQUIRED'

      it 'should hide required message when model value is not empty', ->

        validationOk template, 'bar', 'VALIDATION.REQUIRED'

  describe 'input text ng-minlength validation', ->

    template =
      """
        <form name="form">
          <div form-group>
            <input type="text" name="foo" ng-model="$root.foo" ng-em-minlength="VALIDATION.MIN_LENGTH" ng-minlength="2" />
          </div>
        </form>
      """

    it 'should display minlength message when model value length is less then minlength', ->

      validationFailed template, '1', 'VALIDATION.MIN_LENGTH', '2'

    it 'should hide minlength message when model value length is greater then or equal to minlength', ->

      validationOk template, '12', 'VALIDATION.MIN_LENGTH', '2'