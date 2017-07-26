
import bequestServices from '../services/insurance.service';

let bequestController = angular
  .module('applyController', [bequestServices])
  .controller('InsuranceController', ['$scope', 'InsuranceService', '$location',  function($scope, InsuranceService, $location) {
    const amount =  [100000, 200000, 300000, 400000, 500000, 600000, 700000, 800000, 900000, 1000000, 1100000, 1200000, 1300000, 1400000, 1500000, 1600000, 1700000, 1800000, 1900000, 2000000]
    $scope.errors = [];
    $scope.policyAmount = "";
    var chart = null;
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

    // Get premium for the policy amount
    $scope.getPremium = function(quoteForm) {
      var current_amount_index = amount.indexOf(quoteForm.coverageAmount)

      if(chart) {
        $scope.insurance.coveragePayment =  chart[quoteForm.coverageAge][current_amount_index];
      }
    }

    var prepareData = function() {
      InsuranceService.get('chart_data.json').then(function (response){
        chart = response;
      });
    }

    // Submit coverage form
    $scope.quoteSubmit = function(quoteForm) {
      if (quoteForm.$invalid) {
        return false;
      }
      $scope.insurance.save()
      .then(
        /* success */
        function(response) {
          $scope.insurance = response;
          $location.path('/payment').search('insurance', response.id); // Redirect after the coverage form saved successfully
        },
        /* failure */
        function(error) {
          $scope.errors = error; //Error messages
      });
    }

    prepareData();
  }]);

export default bequestController.name;
