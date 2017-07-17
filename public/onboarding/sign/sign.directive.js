function signDirective() {
  return {
    controller: signController,
    controllerAs: 'signCtrl',
    link: signLink,
    templateUrl: 'sign/sign.html'
  };

  function signController() {
  }

  function signLink() {

  }
}

export default signDirective;