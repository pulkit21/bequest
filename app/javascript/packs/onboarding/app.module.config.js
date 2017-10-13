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
    .state('product', {
      url: '/product',
      template: `<product></product>`
    })
    .state('tobacco', {
      url: '/tobacco',
      template: `<tobacco></tobacco>`
    })
    .state('history', {
      url: '/history',
      template: `<history></history>`
    })
    .state('blood', {
      url: '/blood',
      template: `<blood></blood>`
    })
    .state('cholesterol', {
      url: '/cholesterol',
      template: `<cholesterol></cholesterol>`
    })
    .state('familyHistory', {
      url: '/familyHistory',
      template: `<family_history></family_history>`
    })
    .state('occupation', {
      url: '/occupation',
      template: `<occupation></occupation>`
    })
    .state('driving', {
      url: '/driving',
      template: `<driving></driving>`
    })
    .state('alcohol', {
      url: '/alcohol',
      template: `<alcohol></alcohol>`
    })
    .state('gender', {
      url: '/gender',
      template: `<gender></gender>`
    })
    .state('birthday', {
      url: '/birthday',
      template: `<birthday></birthday>`
    })
    .state('height', {
      url: '/height',
      template: `<height></height>`
    })
    .state('weight', {
      url: '/weight',
      template: `<weight></weight>`
    })
    .state('street', {
      url: '/street',
      template: `<street></street>`
    })
    .state('phone', {
      url: '/phone',
      template: `<phone></phone>`
    })
    .state('license', {
      url: '/license',
      template: `<license></license>`
    })
    .state('coverage', {
      url: '/coverage',
      template: `<coverage></coverage>`
    })
    .state('frequency', {
      url: '/frequency',
      template: `<frequency></frequency>`
    })
    .state('beneficiary', {
      url: '/beneficiary',
      template: `<beneficiary></beneficiary>`
    })
    .state('denied', {
      url: '/denied',
      template: `<denied></denied>`
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
