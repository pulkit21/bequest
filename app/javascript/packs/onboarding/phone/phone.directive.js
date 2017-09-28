function phoneDirective() {
  return {
    controller: phoneController,
    controllerAs: 'phoneCtrl',
    link: phoneLink,
    templateUrl: 'onboarding/apply/phone.html'
  };

  function phoneController() {
  }

  function phoneLink() {

  }
}

export default phoneDirective;
