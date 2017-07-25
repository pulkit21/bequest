
import bequestServices from '../services/insurance.service';

let bequestController = angular
  .module('applyController', [bequestServices])
  .controller('InsuranceController', ['$scope', 'InsuranceService', '$location',  function($scope, InsuranceService, $location) {
    $scope.errors = [];
    var insuranceId = $location.search()['insurance'];
    $scope.insurance = new InsuranceService({});

    if (insuranceId) {
      InsuranceService.get(insuranceId).then(function(insurance){
        $scope.insurance = insurance;
      })
    }

    // Set current date as max date in birthday calander
    $scope.currentDate = function() {
      return new Date();
    }

    // Submit question form
    $scope.questionSubmit = function(questionForm) {
      if (questionForm.$invalid) {
        return false;
      }

      $scope.insurance.save()
      // new InsuranceService(data).save()
      .then(
        /* success */
        function(response) {
          $scope.insurance = response;
          $location.path('/quote').search('insurance', response.id); // Redirect after the question form saved successfully
        },
        /* failure */
        function(error) {
          $scope.errors = error; //Error messages
      });
    };
    // Submit quote form
    $scope.quoteSubmit = function() {
      if ($scope.quoteForm.$valid) {
        console.log('#someButton was clicked');
      }
    }
  }]);

export default bequestController.name;
