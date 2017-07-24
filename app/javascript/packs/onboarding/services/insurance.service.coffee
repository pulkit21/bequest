
import angularjsRailsResource from 'angularjs-rails-resource';

bequestService = angular
  .module('bequest.services', ['rails'])
  .factory 'InsuranceService', (
    RailsResource,
    railsSerializer,
    $location
  ) ->
    class Insurance extends RailsResource
      @configure
        url: ('/api/v1/insurances/'),
        name: 'insurance'

      constructor: ->
        super(arguments...)

export default bequestService.name;
