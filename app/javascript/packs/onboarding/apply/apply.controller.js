
import bequestServices from '../services/insurance.service';

let bequestController = angular
  .module('applyController', [bequestServices])
  .controller('InsuranceController', ['$scope', 'InsuranceService', '$location',  function($scope, InsuranceService, $location) {
    $scope.errors = [];
    // Set current date as max date in birthday calander
    $scope.currentDate = function() {
      return new Date();
    }

    // Submit question button
    $scope.questionSubmit = function() {
      if ($scope.questionForm.$valid) {
        // Build form data
        var data = {
          tobacco_product: $scope.tobaccoProduct,
          health_condition: $scope.healthCondition,
          gender: $scope.gender,
          birthday: $scope.birthday, //Date format YYYY-MM-DD
          height: $scope.height,
          weight: $scope.weight
        }
      }
      new InsuranceService(data).save()
      .then(
        /* success */
        function(response) {
          $location.path('/quote'); // Redirect after the question form saved successfully
        },
        /* failure */
        function(error) {
          $scope.errors = error; //Error messages
      });
    };
  }]);

export default bequestController.name;
