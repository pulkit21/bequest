function familyHistoryDirective() {
  return {
    controller: familyHistoryController,
    controllerAs: 'familyHistoryCtrl',
    link: familyHistoryLink,
    templateUrl: 'onboarding/apply/familyHistory.html'
  };

  function familyHistoryController() {
  }

  function familyHistoryLink() {

  }
}

export default familyHistoryDirective;
