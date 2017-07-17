function quoteDirective() {
  return {
    controller: quoteController,
    controllerAs: 'quoteCtrl',
    link: quoteLink,
    templateUrl: 'onboarding/quote/quote.html'
  };

  function quoteController() {
  }

  function quoteLink() {

  }
}

export default quoteDirective;
