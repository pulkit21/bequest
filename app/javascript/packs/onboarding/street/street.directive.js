function streetDirective() {
  return {
    controller: streetController,
    controllerAs: 'streetCtrl',
    link: streetLink,
    templateUrl: 'onboarding/apply/street.html'
  };

  function streetController() {
  }

  function streetLink() {

  }
}

export default streetDirective;
