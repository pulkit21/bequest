function beneficiaryDirective() {
  return {
    controller: beneficiaryController,
    controllerAs: 'beneficiaryCtrl',
    link: beneficiaryLink,
    templateUrl: 'onboarding/quote/beneficiary.html'
  };

  function beneficiaryController() {
  }

  function beneficiaryLink() {

  }
}

export default beneficiaryDirective;
