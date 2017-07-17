function confirmDirective() {
  return {
    controller: confirmController,
    controllerAs: 'confirmCtrl',
    link: confirmLink,
    templateUrl: 'onboarding/confirm/confirm.html'
  };

  function confirmController() {
  }

  function confirmLink() {

  }
}

export default confirmDirective;
