import bequestService from './insurance.service';


bequestInterceptor = angular
  .module('bequest.interceptors', [])
  .factory 'insuranceInterceptor', ['$q', ($q) ->
    isWatchedHttpMethod = (method) ->
      method in ['get', 'post', 'put']

    afterResponse: (result, resourceConstructor, context) ->
      result.tobaccoProduct = if result.tobaccoProduct then "1" else "0"
      result.healthCondition = if result.healthCondition then "1" else "0"
      result.birthday = new Date(result.birthday)
      result
]
export default bequestInterceptor.name;
