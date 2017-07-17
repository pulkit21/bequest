function learnDirective() {
  return {
    controller: learnController,
    controllerAs: 'learnCtrl',
    link: learnLink,
    templateUrl: 'onboarding/learn/learn.html'
  };

  function learnController() {
  }

  function learnLink() {

  }
}

export default learnDirective;
