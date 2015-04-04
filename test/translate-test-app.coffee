angular

  .module('app', ['bootstrap.formGroup', 'pascalprecht.translate', 'ngMockE2E'])

  .config ($injector) ->

    $translateProvider = $injector.get '$translateProvider'
    $translateProvider.preferredLanguage 'en'
    $translateProvider.translations 'en',
      VALIDATION:
        REQUIRED: 'Require Value'
        MIN_LENGTH: 'At least enter {{value}} characters'
