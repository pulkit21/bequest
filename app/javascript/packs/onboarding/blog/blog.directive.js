function blogDirective() {
  return {
    controller: blogController,
    controllerAs: 'blogCtrl',
    link: blogLink,
    templateUrl: 'onboarding/blog/blog.html'
  };

  function blogController() {
  }

  function blogLink() {

  }
}

export default blogDirective;
