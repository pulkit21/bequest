function deniedDirective() {
  return {
    controller: deniedController,
    controllerAs: 'deniedCtrl',
    link: deniedLink,
    templateUrl: 'onboarding/apply/denied.html'
  };

  function deniedController() {
  }

  function deniedLink() {

  }
}

export default deniedDirective;
