function drivingDirective() {
  return {
    controller: drivingController,
    controllerAs: 'drivingCtrl',
    link: drivingLink,
    templateUrl: 'onboarding/apply/driving.html'
  };

  function drivingController() {
  }

  function drivingLink() {

  }
}

export default drivingDirective;
