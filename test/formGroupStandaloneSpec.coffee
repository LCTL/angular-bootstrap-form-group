describe 'Bootstrap Form Group Directive - Standalone', ->

  $injector = null
  $compile = null
  $rootScope = null

  validation = (template, value, htmlString, htmlContainMessage) ->

    element = $compile(template)($rootScope)

    $rootScope.$apply ->

      $rootScope.foo = value
      $rootScope.form.foo.$setViewValue value

    if htmlContainMessage

      expect(element.html()).to.contain htmlString

    else

      expect(element.html()).not.to.contain htmlString

  validationFailed = (template, value, message) ->

    validation template, value, ">#{message}</p>", true

  validationOk = (template, value, message) ->

    validation template, value, ">#{message}</p>", false

  beforeEach module('bootstrap.formGroup')

  beforeEach inject (_$injector_, _$compile_, _$rootScope_) ->

      $injector = _$injector_
      $compile = _$compile_
      $rootScope = _$rootScope_
      $rootScope.foo = ''

  describe 'Angularjs init', ->

    it 'should $compile not null', ->

      expect($compile).not.to.be.null

    it 'should $rootScope not null', ->

      expect($rootScope).not.to.be.null

  describe 'Directive init', ->

    template =
      """
        <form name="form">
          <div form-group>
            <input type="text" name="foo" />
          </div>
        </form>
      """

    it 'should HTML compiled', ->

      element = $compile(template)($rootScope);

      $rootScope.$digest()

      html = element.html()

      expect(html).to.contain 'class="form-group "'
      expect(html).to.contain 'name="foo"'

    it 'should $rootScope include form object', ->

      element = $compile(template)($rootScope);

      $rootScope.$digest()

      expect($rootScope.form).not.to.be.null

  describe 'Input element', ->

    describe 'input text required validation', ->

      template =
        """
          <form name="form">
            <div form-group>
              <input type="text" name="foo" ng-model="foo" ng-em-required="Require Value" required />
            </div>
          </form>
        """

      it 'should display required message when model value is empty', ->

        validationFailed template, '', 'Require Value'

      it 'should hide required message when model value is not empty', ->

        validationOk template, 'bar', 'Require Value'

    describe 'input text ng-required validation', ->

      template =
        """
          <form name="form">
            <div form-group>
              <input type="text" name="foo" ng-model="foo" ng-em-required="Require Value" ng-required="true" />
            </div>
          </form>
        """

      it 'should display ng-required message when model value is empty', ->

        validationFailed template, '', 'Require Value'

      it 'should hide ng-required message when model value is not empty', ->

        validationOk template, 'bar', 'Require Value'

    describe 'input text ng-minlength validation', ->

      template =
        """
          <form name="form">
            <div form-group>
              <input type="text" name="foo" ng-model="foo" ng-em-minlength="At least enter 2 characters" ng-minlength="2" />
            </div>
          </form>
        """

      it 'should display minlength message when model value length is less then minlength', ->

        validationFailed template, '1', 'At least enter 2 characters'

      it 'should hide minlength message when model value length is greater then or equal to minlength', ->

        validationOk template, '12', 'At least enter 2 characters'

    describe 'input text ng-maxlength validation', ->

      template =
        """
          <form name="form">
            <div form-group>
              <input type="text" name="foo" ng-model="foo" ng-em-maxlength="Cannot over 10 characters" ng-maxlength="10" />
            </div>
          </form>
        """

      it 'should display maxlength message when model value length greater then maxlength', ->

        validationFailed template, '12345678901', 'Cannot over 10 characters'

      it 'should hide maxlength message when model value length less then or equal to maxlength', ->

        validationOk template, '1234567890', 'Cannot over 10 characters'

      it 'should hide maxlength message when model value is empty', ->

        validationOk template, '', 'Cannot over 10 characters'

    describe 'input text ng-maxlength validation', ->

      template =
        """
          <form name="form">
            <div form-group>
              <input type="text" name="foo" ng-model="foo" ng-em-pattern="Only accept input upper case english character" ng-pattern="/^[A-Z]*$/" />
            </div>
          </form>
        """

      it 'should display pattern message when model value include number character', ->

        validationFailed template, 'ABC123', 'Only accept input upper case english character'

      it 'should hide pattern message when model value include upper case english character only', ->

        validationOk template, 'ABCDEFG', 'Only accept input upper case english character'

      it 'should hide pattern message when model value is empty', ->

        validationOk template, '', 'Only accept input upper case english character'

    describe 'input number required validation', ->

      template =
        """
          <form name="form">
            <div form-group>
              <input type="number" name="foo" ng-model="foo" ng-em-required="Require Value" require />
            </div>
          </form>
        """

      it 'should hide require message when model value is not empty', ->

        validationOk template, 1, 'Require Value'

    describe 'input number required validation', ->

      template =
        """
          <form name="form">
            <div form-group>
              <input type="number" name="foo" ng-model="foo" ng-em-required="Require Value" ng-require="true" />
            </div>
          </form>
        """

      it 'should hide ng-require message when model value is not empty', ->

        validationOk template, 1, 'Require Value'

    describe 'input number min validation', ->

      template =
        """
          <form name="form">
            <div form-group>
              <input type="number" name="foo" ng-model="foo" ng-em-min="Cannot less then 10" min="10" />
            </div>
          </form>
        """

      it 'should display min message when model value is less then max value', ->

        validationFailed template, 9, 'Cannot less then 10'

      it 'should hide min message when model value greater then or equal to min value', ->

        validationOk template, 10, 'Cannot less then 10'

    describe 'input number max validation', ->

      template =
        """
          <form name="form">
            <div form-group>
              <input type="number" name="foo" ng-model="foo" ng-em-max="Cannot greater then 10" max="10" />
            </div>
          </form>
        """

      it 'should display max message when model value is greater then max value', ->

        validationFailed template, 11, 'Cannot greater then 10'

      it 'should hide max message when model value less then or equal to max value', ->

        validationOk template, 10, 'Cannot greater then 10'

    describe 'input custom validation', ->

      listener = null
      template =
        """
          <form name="form">
            <div form-group>
              <input type="number" name="foo" ng-model="foo" ng-em-custom-validation="Custom Message" />
            </div>
          </form>
        """

      beforeEach ->

        listener = $rootScope.$watch 'foo', (newValue, oldValue) ->

          $rootScope.form.foo.$setValidity 'CUSTOM-VALIDATION', newValue is 'A'

      afterEach ->

        listener()

      it 'should display custom message when model value is B', ->

        validationFailed template, 'B', 'Custom Message'

      it 'should hide custom message when model value is A', ->

        validationOk template, 'A', 'Custom Message'

  describe 'select element', ->

    beforeEach () ->

      $rootScope.items = ['A', 'B', 'C', 'D']

    describe 'select required validation', ->

      template =
        """
          <form name="form">
            <div form-group>
              <select name="foo" ng-options="item for item in $root.items" ng-model="foo" ng-em-required="Require Value" required>
            </div>
          </form>
        """

      it 'should display require message when model value is null', ->

        validationFailed template, null, 'Require Value'

      it 'should hide require message when model value is not empty', ->

        validationOk template, $rootScope.items[0], 'Require Value'

    describe 'select required validation', ->

      template =
        """
          <form name="form">
            <div form-group>
              <select name="foo" ng-options="item for item in $root.items" ng-model="foo" ng-em-required="Require Value" required>
            </div>
          </form>
        """

      it 'should display require message when model value is null', ->

        validationFailed template, null, 'Require Value'

      it 'should hide require message when model value is not empty', ->

        validationOk template, $rootScope.items[0], 'Require Value'