function occupationDirective() {
  return {
    controller: occupationController,
    controllerAs: 'occupationCtrl',
    link: occupationLink,
    templateUrl: 'onboarding/apply/occupation.html'
  };

  function occupationController() {
  }

  function occupationLink() {

  }
}

export default occupationDirective;
