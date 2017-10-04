function historyDirective() {
  return {
    controller: historyController,
    controllerAs: 'historyCtrl',
    link: historyLink,
    templateUrl: 'onboarding/apply/history.html'
  };

  function historyController() {
  }

  function historyLink() {

  }
}

export default historyDirective;
