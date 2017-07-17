function registerDirective() {
  return {
    controller: registerController,
    controllerAs: 'registerCtrl',
    link: registerLink,
    templateUrl: 'onboarding/register/register.html'
  };

  function registerController() {
  }

  function registerLink() {

  }
}

export default registerDirective;
