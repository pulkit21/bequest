import bequestServices from '../services/insurance.service';

let confirmController = angular
  .module('confirmController', [bequestServices])
  .controller('ConfirmController', ['$scope', 'InsuranceService', '$location', '$http', function($scope, InsuranceService, $location, $http) {

    var getInsurancePdf = function() {
      var insuranceId = $location.search()['insurance'];
      $scope.insurance = new InsuranceService({});
      $scope.policy = null;
      if (insuranceId) {
        InsuranceService.get(insuranceId).then(function(insurance){
          $scope.insurance = insurance;
        })
      }
      var data = {
        id: insuranceId
      }
      $http.post('/api/v1/insurances/download_policy', data).then(function(response) {
        $scope.policy = response.data.url
      });
    }

    getInsurancePdf();
  }]);


export default confirmController.name;
