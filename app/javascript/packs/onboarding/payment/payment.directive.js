function paymentDirective() {
  return {
    controller: paymentController,
    controllerAs: 'paymentCtrl',
    link: paymentLink,
    templateUrl: 'onboarding/payment/payment.html'
  };

  function paymentController() {
  }

  function paymentLink() {

  }
}

export default paymentDirective;
