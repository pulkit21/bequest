
import angularjsRailsResource from 'angularjs-rails-resource';
import bequestInterceptor from './insurance.interceptor';

bequestService = angular
  .module('bequest.services',  ['rails', bequestInterceptor])
  .factory 'InsuranceService', ['RailsResource', 'railsSerializer', '$location', 'insuranceInterceptor', (RailsResource, railsSerializer, $location, insuranceInterceptor) ->
    class Insurance extends RailsResource
      @configure
        url: ('/api/v1/insurances/'),
        name: 'insurance'
        interceptors: [insuranceInterceptor]
      constructor: ->
        super(arguments...)
]
export default bequestService.name;
