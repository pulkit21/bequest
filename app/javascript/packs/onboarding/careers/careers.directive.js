function careersDirective() {
  return {
    controller: careersController,
    controllerAs: 'careersCtrl',
    link: careersLink,
    templateUrl: 'onboarding/careers/careers.html'
  };

  function careersController() {
  }

  function careersLink() {

  }
}

export default careersDirective;
