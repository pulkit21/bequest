function aboutDirective() {
  return {
    controller: aboutController,
    controllerAs: 'aboutCtrl',
    link: aboutLink,
    templateUrl: 'onboarding/about/about.html'
  };

  function aboutController() {
  }

  function aboutLink() {

  }
}

export default aboutDirective;
