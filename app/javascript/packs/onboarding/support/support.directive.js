function supportDirective() {
  return {
    controller: supportController,
    controllerAs: 'supportCtrl',
    link: supportLink,
    templateUrl: 'onboarding/support/support.html'
  };

  function supportController() {
  }

  function supportLink() {

  }
}

export default supportDirective;
