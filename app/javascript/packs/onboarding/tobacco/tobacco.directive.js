function tobaccoDirective() {
  return {
    controller: tobaccoController,
    controllerAs: 'tobaccoCtrl',
    link: tobaccoLink,
    templateUrl: 'onboarding/apply/tobacco.html'
  };

  function tobaccoController() {
  }

  function tobaccoLink() {

  }
}

export default tobaccoDirective;
