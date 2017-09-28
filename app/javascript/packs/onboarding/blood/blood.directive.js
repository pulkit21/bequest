function bloodDirective() {
  return {
    controller: bloodController,
    controllerAs: 'bloodCtrl',
    link: bloodLink,
    templateUrl: 'onboarding/apply/blood.html'
  };

  function bloodController() {
  }

  function bloodLink() {

  }
}

export default bloodDirective;
