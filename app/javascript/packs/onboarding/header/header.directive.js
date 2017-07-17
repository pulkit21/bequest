function headerDirective() {
  return {
    controller: headerController,
    controllerAs: 'headerCtrl',
    link: headerLink,
    templateUrl: 'onboarding/header/header.html'
  };

  function headerController() {
  }

  function headerLink() {

  }
}

export default headerDirective;
