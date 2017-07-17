function pressDirective() {
  return {
    controller: pressController,
    controllerAs: 'pressCtrl',
    link: pressLink,
    templateUrl: 'onboarding/press/press.html'
  };

  function pressController() {
  }

  function pressLink() {

  }
}

export default pressDirective;
