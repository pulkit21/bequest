function applyDirective() {
  return {
    controller: applyController,
    controllerAs: 'applyCtrl',
    link: applyLink,
    templateUrl: 'onboarding/apply/apply.html'
  };

  function applyController() {
  }

  function applyLink() {

  }
}

export default applyDirective;
