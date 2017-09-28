function weightDirective() {
  return {
    controller: weightController,
    controllerAs: 'weightCtrl',
    link: weightLink,
    templateUrl: 'onboarding/apply/weight.html'
  };

  function weightController() {
  }

  function weightLink() {

  }
}

export default weightDirective;
