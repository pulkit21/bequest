function privacyDirective() {
  return {
    controller: privacyController,
    controllerAs: 'privacyCtrl',
    link: privacyLink,
    templateUrl: 'onboarding/privacy/privacy.html'
  };

  function privacyController() {
  }

  function privacyLink() {

  }
}

export default privacyDirective;
