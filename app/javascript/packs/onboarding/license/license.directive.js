function licenseDirective() {
  return {
    controller: licenseController,
    controllerAs: 'licenseCtrl',
    link: licenseLink,
    templateUrl: 'onboarding/apply/license.html'
  };

  function licenseController() {
  }

  function licenseLink() {

  }
}

export default licenseDirective;
