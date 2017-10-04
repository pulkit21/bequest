function genderDirective() {
  return {
    controller: genderController,
    controllerAs: 'genderCtrl',
    link: genderLink,
    templateUrl: 'onboarding/apply/gender.html'
  };

  function genderController() {
  }

  function genderLink() {

  }
}

export default genderDirective;
