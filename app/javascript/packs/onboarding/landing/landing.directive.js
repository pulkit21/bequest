import './landing.scss';

function landingDirective() {
  return {
    controller: landingController,
    controllerAs: 'landingCtrl',
    link: landingLink,
    templateUrl: 'onboarding/landing/landing.html'
  };

  function landingController() {
  }

  function landingLink() {

  }

}

export default landingDirective;
