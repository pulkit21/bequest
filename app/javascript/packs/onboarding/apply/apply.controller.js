
import bequestServices from '../services/insurance.service';

let bequestController = angular
  .module('applyController', [bequestServices])
  .controller('InsuranceController', [
    '$scope',
    'InsuranceService',
    '$location',
    '$http',
    '$mdToast',
    '$window',
    '$rootScope',
    function(
      $scope,
      InsuranceService,
      $location,
      $http,
      $mdToast,
      $window,
      $rootScope
    ) {
    const amount =  [25000, 50000, 75000, 100000, 125000, 150000, 175000, 200000, 225000, 250000, 275000, 300000, 325000, 350000, 375000, 400000, 425000, 450000, 475000, 500000, 525000, 550000, 575000, 600000, 625000, 650000, 675000, 700000, 725000, 750000, 775000, 800000, 825000, 850000, 875000, 900000, 925000, 950000, 975000, 1000000, 1025000, 1050000, 1075000, 1100000, 1125000, 1150000, 1175000, 1200000, 1225000, 1250000, 1275000, 1300000, 1325000, 1350000, 1375000, 1400000, 1425000, 1450000, 1475000, 1500000, 1525000, 1550000, 1575000, 1600000, 1625000, 1650000, 1675000, 1700000, 1725000, 1750000, 1775000, 1800000, 1825000, 1850000, 1875000, 1900000, 1925000, 1950000, 1975000, 2000000]
    $scope.heightInchesOptions = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]
    $scope.coverageTermAge = "";
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

    // Go back button
    $rootScope.goBack = function(insurance) {
      InsuranceService.$put('/api/v1/insurances/revert_back', {id: insurance.id}).then(
        function (response){
          $scope.insurance.aasmState = response.aasmState;
          $window.history.back();
      },
      function(error){

      });
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
          .hideDelay(0)
      );
    }
    // End of Toast Message

    // Select term product
    $scope.termProduct = function() {
      $scope.insurance.user_id = $location.search().user;
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

    // Usage of tobacco
    $scope.tobaccoSelect = function(tobacco) {
      $scope.insurance.tobacco_product = tobacco;
      $scope.insurance.save()
      .then(
        function(response) {
          if(response.tobacco_product){
            $location.url('/history').search('insurance', response.id);
          } else {
            $location.url('/denied');
          }
        },
        function(error) {
          $scope.showToastMessage("We are unable to offer coverage to you at this time.")
      });
    }

    // Any Health Issues
    $scope.healthConditions = function(healthIssue) {
      $scope.insurance.health_condition = healthIssue;
      $scope.insurance.save()
      .then(
        function(response) {
          if(response.health_condition){
            $location.url('/blood').search('insurance', response.id);
          } else {
            $location.url('/denied');
          }
        },
        function(error) {
          $scope.showToastMessage("Please select have any health conditions.")
      });
    }

    // Blood condition
    $scope.haveBloodPressure = function(bloodPressure) {
      $scope.insurance.blood = bloodPressure;
      $scope.insurance.save()
      .then(
        function(response) {
          if(response.blood){
            $location.url('/cholesterol').search('insurance', response.id);
          } else {
            $location.url('/denied');
          }
        },
        function(error) {
          $scope.showToastMessage("Please select have any blood pressure.")
      });
    }

    // cholesterol problem
    $scope.haveCholesterolIssue = function(cholesterol) {
      $scope.insurance.cholesterol = cholesterol;
      $scope.insurance.save()
      .then(
        function(response) {
          if(response.cholesterol){
            $location.url('/familyHistory').search('insurance', response.id);
          } else {
            $location.url('/denied');
          }
        },
        function(error) {
          $scope.showToastMessage("Please select have high cholesterol.")
      });
    }


    // Family problem
    $scope.haveFamilyProblem = function(familyHistory) {
      $scope.insurance.family_history = familyHistory;
      $scope.insurance.save()
      .then(
        function(response) {
          if(response.family_history){
            $location.url('/occupation').search('insurance', response.id);
          } else {
            $location.url('/denied');
          }
        },
        function(error) {
          $scope.showToastMessage("Please select have family history.")
      });
    }

    // occupation  Hazardous
    $scope.occupationHazard = function(occupation) {
      $scope.insurance.occupation = occupation;
      $scope.insurance.save()
      .then(
        function(response) {
          if(response.occupation){
            $location.url('/driving').search('insurance', response.id);
          } else {
            $location.url('/denied');
          }
        },
        function(error) {
          $scope.showToastMessage("Please select have Hazardous occupation or hobby.")
      });
    }

    // driving charges
    $scope.drivingCharge = function(driving) {
      $scope.insurance.driving = driving;
      $scope.insurance.save()
      .then(
        function(response) {
          if(response.driving){
            $location.url('/alcohol').search('insurance', response.id);
          } else {
            $location.url('/denied');
          }
        },
        function(error) {
          $scope.showToastMessage("Please select have driving charges.")
      });
    }

    // driving charges
    $scope.alcoholusage = function(alcohol) {
      $scope.insurance.alcohol = alcohol;
      $scope.insurance.save()
      .then(
        function(response) {
          if(response.alcohol){
            $location.url('/gender').search('insurance', response.id);
          } else {
            $location.url('/denied');
          }
        },
        function(error) {
          $scope.showToastMessage("Please select have use alcohol or drugs.")
      });
    }

    // driving charges
    $scope.selectGender = function(gender) {
      $scope.insurance.gender = gender;
      $scope.insurance.save()
      .then(
        function(response) {
          $location.url('/birthday').search('insurance', response.id);
        },
        function(error) {
          $scope.showToastMessage("Please select gender.")
      });
    }

    $scope.findCoverageAge = function() {
     var currentAge = new Date().getYear() - new Date(this.birthdayForm.birthday.$viewValue).getYear()
     var termAge = 65 - currentAge
     $scope.coverageTermAge = (termAge > 0) ? termAge : 0
    }

    // Set current date as max date in birthday calander
    $scope.currentDate = function() {
      return new Date();
    }

    // birthday
    $scope.birthdaySubmit = function(birthdayForm) {
      if (birthdayForm.$invalid) {
        return false;
      }
      birthdayForm.birthday = birthdayForm.birthday;
      $scope.insurance.save()
      .then(
        /* success */
        function(response) {
          $mdToast.hide();
          $location.url('/height').search('insurance', response.id);
          // $location.path('/quote').search('insurance', response.id); // Redirect after the question form saved successfully
        },
        /* failure */
        function(error) {
          $scope.showToastMessage(error.data.age_coverage[0])
          // $scope.errors = error; //Error messages
      });
    }

    // height
    $scope.heightSubmit = function(heightForm) {
      if (heightForm.$invalid) {
        return false;
      }
      $scope.insurance.save()
      .then(
        /* success */
        function(response) {
          $mdToast.hide();
          $location.url('/weight').search('insurance', response.id);
          // $location.path('/quote').search('insurance', response.id); // Redirect after the question form saved successfully
        },
        /* failure */
        function(error) {
          $scope.showToastMessage(error)
          $scope.errors = error; //Error messages
      });
    }

    // weight
    $scope.weightSubmit = function(weightForm) {
      if (weightForm.$invalid) {
        return false;
      }
      $scope.insurance.save()
      .then(
        /* success */
        function(response) {
          $mdToast.hide();
          $location.url('/street').search('insurance', response.id);
          // $location.path('/quote').search('insurance', response.id); // Redirect after the question form saved successfully
        },
        /* failure */
        function(error) {
          $scope.showToastMessage(error.data.weight_coverage[0])
      });
    }

    // street
    $scope.streetSubmit = function(streetForm) {
      if (streetForm.$invalid) {
        return false;
      }
      $scope.insurance.save()
      .then(
        /* success */
        function(response) {
          $mdToast.hide();
          $location.url('/phone').search('insurance', response.id);
          // $location.path('/quote').search('insurance', response.id); // Redirect after the question form saved successfully
        },
        /* failure */
        function(error) {
          $scope.showToastMessage(error.data.weight_coverage[0])
      });
    }

    // phone
    $scope.phoneSubmit = function(phoneForm) {
      if (phoneForm.$invalid) {
        return false;
      }
      $scope.insurance.save()
      .then(
        /* success */
        function(response) {
          $mdToast.hide();
          $location.url('/license').search('insurance', response.id);
          // $location.path('/quote').search('insurance', response.id); // Redirect after the question form saved successfully
        },
        /* failure */
        function(error) {
          $scope.showToastMessage("Phone number " + error.data.phone_number[0])
      });
    }


    // license
    $scope.licenseSubmit = function(licenseForm) {
      if (licenseForm.$invalid) {
        return false;
      }
      $scope.insurance.save()
      .then(
        /* success */
        function(response) {
          $mdToast.hide();
          $location.url('/coverage').search('insurance', response.id);
          // $location.path('/quote').search('insurance', response.id); // Redirect after the question form saved successfully
        },
        /* failure */
        function(error) {
          $scope.showToastMessage("Invalid license")
      });
    }

    // Fetch the Chart to calculate the premium per month
    var prepareData = function() {
      InsuranceService.get('chart_data.json').then(function (response){
        chart = response;
      });
    }

    // Get premium for the policy amount
    $scope.getPremium = function(quoteForm) {

      var current_amount_index = amount.indexOf(quoteForm.coverageAmount)

      if(chart) {
        if (quoteForm.gender == "male") {
          $scope.insurance.coveragePayment =  chart["termMaleData"][quoteForm.coverageAge][current_amount_index];
        } else {
          $scope.insurance.coveragePayment =  chart["termFemaleData"][quoteForm.coverageAge][current_amount_index];
        }
      }
      if (quoteForm.coverageAmount && quoteForm.coveragePayment && quoteForm.paymentFrequency) {
        premiumCalculator(quoteForm);
      }
    }

    // Calculate the premium payment percentage
    var premiumCalculator = function(quoteForm) {
      var current_amount_index = amount.indexOf(quoteForm.coverageAmount)
      if (quoteForm.gender == "male") {
        var premiumAmount =  chart["termMaleData"][quoteForm.coverageAge][current_amount_index];
      } else {
        var premiumAmount =  chart["termFemaleData"][quoteForm.coverageAge][current_amount_index];
      }

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

    // coverage
    $scope.coverageSubmit = function(coverageForm) {
      if (coverageForm.$invalid) {
        return false;
      }
      $scope.insurance.save()
      .then(
        /* success */
        function(response) {
          $mdToast.hide();
          $location.url('/frequency').search('insurance', response.id);
          // $location.path('/quote').search('insurance', response.id); // Redirect after the question form saved successfully
        },
        /* failure */
        function(error) {
          var errorMsg = error.coverage_payment != null ? error.data.coverage_payment[0] : error.data.coverage_amount[0];
          $scope.showToastMessage(errorMsg)
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

    // frequency
    $scope.frequencySubmit = function(frequencyForm) {
      if (frequencyForm.$invalid) {
        return false;
      }
      $scope.insurance.save()
      .then(
        /* success */
        function(response) {
          $mdToast.hide();
          $location.url('/beneficiary').search('insurance', response.id);
          // $location.path('/quote').search('insurance', response.id); // Redirect after the question form saved successfully
        },
        /* failure */
        function(error) {
          $scope.showToastMessage(error.data.frequency[0])
      });
    }

    $scope.beneficiaries_attributes = [{name: 'Beneficiary 1'}];

    $scope.addNewBeneficiary = function() {
      var newItemNo = $scope.beneficiaries_attributes.length+1;
      $scope.beneficiaries_attributes.push({'name':'Beneficiary '+ newItemNo});
    };

    $scope.removeBeneficiary = function() {
      var lastItem = $scope.beneficiaries_attributes.length-1;
      $scope.beneficiaries_attributes.splice(lastItem);
    };

    $scope.beneficiarySubmit = function(beneficiaryForm) {
      $scope.insurance.beneficiaries_attributes = $scope.beneficiaries_attributes;
      if (beneficiaryForm.$invalid) {
        return false;
      }
      $scope.insurance.save()
      .then(
        /* success */
        function(response) {
          $mdToast.hide();
          $location.url('/payment').search('insurance', response.id);
          // $location.path('/quote').search('insurance', response.id); // Redirect after the question form saved successfully
        },
        /* failure */
        function(error) {
          $scope.showToastMessage(error.data.beneficiaries[0])
      });
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
          $mdToast.hide();
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

// Range Filter
bequestController.filter('toRange', function() {
  return function(input) {
    var highBound, i, lowBound, ref, ref1, result;
    switch (input.length) {
      case 1:
        ref = [0, +input[0] - 1], lowBound = ref[0], highBound = ref[1];
        break;
      case 2:
        ref1 = [+input[0], +input[1]], lowBound = ref1[0], highBound = ref1[1];
    }
    i = lowBound;
    result = [];
    while (i <= highBound) {
      result.push(i);
      i++;
    }
    return result;
  };
});
