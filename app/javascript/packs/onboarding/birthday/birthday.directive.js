function birthdayDirective() {
  return {
    controller: birthdayController,
    controllerAs: 'birthdayCtrl',
    link: birthdayLink,
    templateUrl: 'onboarding/apply/birthday.html'
  };

  function birthdayController() {
  }

  function birthdayLink() {

  }
}

export default birthdayDirective;
