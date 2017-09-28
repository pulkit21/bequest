function coverageDirective() {
  return {
    controller: coverageController,
    controllerAs: 'coverageCtrl',
    link: coverageLink,
    templateUrl: 'onboarding/quote/coverage.html'
  };

  function coverageController() {
  }

  function coverageLink() {

  }
}

export default coverageDirective;
