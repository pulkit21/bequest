defaultModuleConfig.$inject = [
  '$stateProvider',
  '$urlRouterProvider',
  '$locationProvider'
];
function defaultModuleConfig($stateProvider, $urlRouterProvider, $locationProvider) {
  $urlRouterProvider.otherwise('/');
  $stateProvider


    .state('register', {
      url: '/register',
      template: `<register></register>`
    })
    .state('sign', {
      url: '/sign',
      template: `<sign></sign>`
    })
    .state('apply', {
      url: '/apply',
      template: `<apply></apply>`
    })
    .state('payment', {
      url: '/payment',
      template: `<payment></payment>`
    })
    .state('quote', {
      url: '/quote',
      template: `<quote></quote>`
    })
    .state('confirm', {
      url: '/confirm',
      template: `<confirm></confirm>`
    })




    .state('contact', {
      url: '/contact',
      template: `<contact></contact>`
    })
    .state('careers', {
      url: '/careers',
      template: `<careers></careers>`
    })
    .state('learn', {
      url: '/learn',
      template: `<learn></learn>`
    })
    .state('compare', {
      url: '/compare',
      template: `<compare></compare>`
    })
    .state('support', {
      url: '/support',
      template: `<support></support>`
    })
    .state('press', {
      url: '/press',
      template: `<press></press>`
    })
    .state('terms', {
      url: '/terms',
      template: `<terms></terms>`
    })
    .state('privacy', {
      url: '/privacy',
      template: `<privacy></privacy>`
    })
    .state('blog', {
      url: '/blog',
      template: `<blog></blog>`
    });
    $locationProvider.html5Mode(true);
}

// defaultModuleRun.$inject = ['$location', '$rootScope', '$window'];
// function defaultModuleRun($location, $rootScope, $window) {
//   $window.ga('create', 'UA-XXXXXXXX-X', 'auto');
//   $rootScope.$on('$stateChangeSuccess', function() {
//     $window.ga('send', 'pageview', $location.path());
//   });
// }

export {defaultModuleConfig};
