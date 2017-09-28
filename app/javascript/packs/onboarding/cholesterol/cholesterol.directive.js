function cholesterolDirective() {
  return {
    controller: cholesterolController,
    controllerAs: 'cholesterolCtrl',
    link: cholesterolLink,
    templateUrl: 'onboarding/apply/cholesterol.html'
  };

  function cholesterolController() {
  }

  function cholesterolLink() {

  }
}

export default cholesterolDirective;
