function heightDirective() {
  return {
    controller: heightController,
    controllerAs: 'heightCtrl',
    link: heightLink,
    templateUrl: 'onboarding/apply/height.html'
  };

  function heightController() {
  }

  function heightLink() {

  }
}

export default heightDirective;
