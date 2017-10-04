function frequencyDirective() {
  return {
    controller: frequencyController,
    controllerAs: 'frequencyCtrl',
    link: frequencyLink,
    templateUrl: 'onboarding/quote/frequency.html'
  };

  function frequencyController() {
  }

  function frequencyLink() {

  }
}

export default frequencyDirective;
