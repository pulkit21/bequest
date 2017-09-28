function alcoholDirective() {
  return {
    controller: alcoholController,
    controllerAs: 'alcoholCtrl',
    link: alcoholLink,
    templateUrl: 'onboarding/apply/alcohol.html'
  };

  function alcoholController() {
  }

  function alcoholLink() {

  }
}

export default alcoholDirective;
