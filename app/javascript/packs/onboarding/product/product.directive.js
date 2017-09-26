function productDirective() {
  return {
    controller: productController,
    controllerAs: 'productCtrl',
    link: productLink,
    templateUrl: 'onboarding/apply/product.html'
  };

  function productController() {
  }

  function productLink() {

  }
}

export default productDirective;
