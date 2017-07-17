function contactDirective() {
  return {
    controller: contactController,
    controllerAs: 'contactCtrl',
    link: contactLink,
    templateUrl: 'onboarding/contact/contact.html'
  };

  function contactController() {
  }

  function contactLink() {

  }
}

export default contactDirective;
