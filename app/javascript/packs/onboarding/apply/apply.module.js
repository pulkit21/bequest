import angular from 'angular';
import applyDirective from './apply.directive';

let applyModule = angular
  .module('applyModule', [require('angular-resource')])
  .directive('apply', applyDirective)

  applyModule.controller("applyCtrl", function($scope, $http, $resource) {

    $http.defaults.useXDomain = true;
    Something = $resource("http://localhost:5000/api/v1/insurances/:id", {id: "@id"});
    $scope.something = Something.get({id: "00266d45-ecf6-450f-8714-971085c91290"});

    // applyModule.factory("InsuranceService", function($resource) {
    //   return $resource('http://localhost:5000/api/vi/insurances/:id', {}, {update: { method: 'PUT' }});
    // });

    // $scope.books = InsuranceService.query(function(data) {
    //   console.log("Got all books", data);
    // });
            // return $resource('http://localhost:5000/api/v1/insurances', {},  {update: { method: 'PUT' }});
  })

export default applyModule.name;
