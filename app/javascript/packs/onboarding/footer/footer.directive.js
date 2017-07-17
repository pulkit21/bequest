function footerDirective() {
  return {
    controller: footerController,
    controllerAs: 'footerCtrl',
    link: footerLink,
    templateUrl: 'onboarding/footer/footer.html'
  };

  function footerController() {
  }

  function footerLink() {

  }
}

export default footerDirective;
