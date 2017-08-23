
import bequestServices from '../services/insurance.service';

let bequestController = angular
  .module('applyController', [bequestServices])
  .controller('InsuranceController', ['$scope', 'InsuranceService', '$location', '$http', function($scope, InsuranceService, $location, $http) {
    const amount =  [100000, 200000, 300000, 400000, 500000, 600000, 700000, 800000, 900000, 1000000, 1100000, 1200000, 1300000, 1400000, 1500000, 1600000, 1700000, 1800000, 1900000, 2000000]
    $scope.errors = [];
    $scope.stripeErrors = null;
    var chart = null;
    var insuranceId = $location.search()['insurance'];
    $scope.insurance = new InsuranceService({});
    $scope.cardDetails = {}
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
        $scope.insurance.coveragePayment =  chart[quoteForm.coverageAge][current_amount_index];;
      }
      if (quoteForm.coverageAmount && quoteForm.coveragePayment && quoteForm.paymentFrequency) {
        premiumCalculator(quoteForm);
      }
    }

    // Calculate the premium payment percentage
    var premiumCalculator = function(quoteForm) {
      var current_amount_index = amount.indexOf(quoteForm.coverageAmount)
      var premiumAmount = chart[quoteForm.coverageAge][current_amount_index];

      if (quoteForm.paymentFrequency === "semi") {
        quoteForm.coveragePayment = ((10 / premiumAmount) * 100) + premiumAmount
      }
      else if (quoteForm.paymentFrequency === "quarterly") {
        quoteForm.coveragePayment = ((20 / premiumAmount) * 100) + premiumAmount
      }
      else if (quoteForm.paymentFrequency === "monthly") {
        quoteForm.coveragePayment = ((30 / premiumAmount) * 100) + premiumAmount
      }
      else {
        quoteForm.coveragePayment = premiumAmount
      }
      quoteForm.coveragePayment = parseFloat(quoteForm.coveragePayment).toFixed(2);
    }

    // Fetch the Chart to calculate the premium per month
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

    // Change the premium amount according to the payment frequency
    $scope.getPremiumCharge = function(quoteForm) {
      if (quoteForm.coverageAmount && quoteForm.coveragePayment) {
        premiumCalculator(quoteForm);
      }
      else {
        quoteForm.paymentFrequency = "";
        return false;
      }
    }

    // Handeling Stripe payment
    $scope.stripeCallback = function(code, result) {
      if (result.error) {
        $scope.stripeErrors = result.error.message
        console.log('it failed! error: ' + result.error.message);
      } else {
        var data = {
          id: $scope.insurance.id,
          stripe_token: result.id,
          stripe_response: result,
          terms_and_services: $scope.insurance.termsAndServices
        }

        $http.post('/api/v1/insurances/stripe', data).then(function(response) {
          $scope.insurance = response.data;
          $location.path('/sign').search('insurance', response.data.id);
        }, function(response) {
          console.log('it failed! error: ' + response.data.error);
          $scope.stripeErrors = response.data.error;
        });
      }
    }

    // Handel Docusign Signature
    $scope.getSignature = function(signForm) {
      var data = {
        id: signForm.id
      }
      $http.post('/api/v1/insurances/signature', data).then(function(response) {
        window.location = response.data.url
        // $scope.insurance = response.data;
        // $location.path('/sign').search('insurance', response.data.id);
      });
    }

    prepareData();
  }]);

export default bequestController.name;
