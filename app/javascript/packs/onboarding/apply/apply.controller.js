
import bequestServices from '../services/insurance.service';

let bequestController = angular
  .module('applyController', [bequestServices])
  .controller('InsuranceController', ['$scope', 'InsuranceService', '$location', '$http', '$mdToast', function($scope, InsuranceService, $location, $http, $mdToast) {
    const amount =  [25000, 50000, 75000, 100000, 125000, 150000, 175000, 200000, 225000, 250000, 275000, 300000, 325000, 350000, 375000, 400000, 425000, 450000, 475000, 500000, 525000, 550000, 575000, 600000, 625000, 650000, 675000, 700000, 725000, 750000, 775000, 800000, 825000, 850000, 875000, 900000, 925000, 950000, 975000, 1000000, 1025000, 1050000, 1075000, 1100000, 1125000, 1150000, 1175000, 1200000, 1225000, 1250000, 1275000, 1300000, 1325000, 1350000, 1375000, 1400000, 1425000, 1450000, 1475000, 1500000, 1525000, 1550000, 1575000, 1600000, 1625000, 1650000, 1675000, 1700000, 1725000, 1750000, 1775000, 1800000, 1825000, 1850000, 1875000, 1900000, 1925000, 1950000, 1975000, 2000000]
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

    // Start Toast Message
    var last = {
      bottom: false,
      top: true,
      left: false,
      right: true
    };

    $scope.toastPosition = angular.extend({},last);

    $scope.getToastPosition = function() {
      sanitizePosition();

      return Object.keys($scope.toastPosition)
        .filter(function(pos) { return $scope.toastPosition[pos]; })
        .join(' ');
    };

    function sanitizePosition() {
      var current = $scope.toastPosition;

      if ( current.bottom && last.top ) current.top = false;
      if ( current.top && last.bottom ) current.bottom = false;
      if ( current.right && last.left ) current.left = false;
      if ( current.left && last.right ) current.right = false;

      last = angular.extend({},current);
    }

    $scope.showToastMessage = function(message) {
      var pinTo = $scope.getToastPosition();
      $mdToast.show(
        $mdToast.simple()
          .textContent(message)
          .position(pinTo )
          .hideDelay(10000)
      );
    }
    // End of Toast Message

    // Select term product
    $scope.termProduct = function() {
      $scope.insurance.product = "Term";
      $scope.insurance.save()
      .then(
        function(response) {
          $location.url('/tobacco').search('insurance', response.id);
        },
        function(error) {
          $scope.showToastMessage("Please select the coverage type.")
      });
    };

    // Set current date as max date in birthday calander
    $scope.currentDate = function() {
      return new Date();
    }

    // Submit question form
    $scope.questionSubmit = function(questionForm) {
      if (questionForm.$invalid) {
        return false;
      }

      $scope.insurance.user_id = $location.search().user;
      $scope.insurance.save()
      // new InsuranceService(data).save()
      .then(
        /* success */
        function(response) {
          $location.url('/quote').search('insurance', response.id);
          // $location.path('/quote').search('insurance', response.id); // Redirect after the question form saved successfully
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
        quoteForm.coveragePayment = (premiumAmount * .1) + premiumAmount
      }
      else if (quoteForm.paymentFrequency === "quarterly") {
        quoteForm.coveragePayment = (premiumAmount * .2) + premiumAmount
      }
      else if (quoteForm.paymentFrequency === "monthly") {
        quoteForm.coveragePayment = (premiumAmount * .3) + premiumAmount
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
