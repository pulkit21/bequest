function termsDirective() {
  return {
    controller: termsController,
    controllerAs: 'termsCtrl',
    link: termsLink,
    templateUrl: 'onboarding/terms/terms.html'
  };

  function termsController() {
  }

  function termsLink() {

  }
}

export default termsDirective;
