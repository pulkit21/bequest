defaultModuleConfig.$inject = [
  '$stateProvider',
  '$urlRouterProvider',
  '$locationProvider'
];
function defaultModuleConfig($stateProvider, $urlRouterProvider, $locationProvider) {
  $urlRouterProvider.otherwise('/');
  $stateProvider

    .state('landing', {
      url: '/',
      template: `<header></header>
                 <landing></landing>
                 <footer></footer>`
    })




    .state('register', {
      url: '/register',
      template: `<header></header>
                 <register></register>
                 <footer></footer>`
    })
    .state('sign', {
      url: '/sign',
      template: `<header></header>
                 <sign></sign>
                 <footer></footer>`
    })
    .state('apply', {
      url: '/apply',
      template: `<header></header>
                 <apply></apply>
                 <footer></footer>`
    })
    .state('payment', {
      url: '/payment',
      template: `<header></header>
                 <payment></payment>
                 <footer></footer>`
    })
    .state('quote', {
      url: '/quote',
      template: `<header></header>
                 <quote></quote>
                 <footer></footer>`
    })
    .state('confirm', {
      url: '/confirm',
      template: `<header></header>
                 <confirm></confirm>
                 <footer></footer>`
    })




    .state('contact', {
      url: '/contact',
      template: `<header></header>
                 <contact></contact>
                 <footer></footer>`
    })
    .state('about', {
      url: '/about',
      template: `<header></header>
                 <about></about>
                 <footer></footer>`
    })
    .state('careers', {
      url: '/careers',
      template: `<header></header>
                 <about></about>
                 <footer></footer>`
    })
    .state('learn', {
      url: '/learn',
      template: `<header></header>
                 <learn></learn>
                 <footer></footer>`
    })
    .state('compare', {
      url: '/compare',
      template: `<header></header>
                 <compare></compare>
                 <footer></footer>`
    })
    .state('support', {
      url: '/support',
      template: `<header></header>
                 <support></support>
                 <footer></footer>`
    })
    .state('press', {
      url: '/press',
      template: `<header></header>
                 <press></press>
                 <footer></footer>`
    })
    .state('terms', {
      url: '/terms',
      template: `<header></header>
                 <terms></terms>
                 <footer></footer>`
    })
    .state('privacy', {
      url: '/privacy',
      template: `<header></header>
                 <privacy></privacy>
                 <footer></footer>`
    })
    .state('blog', {
      url: '/blog',
      template: `<header></header>
                 <blog></blog>
                 <footer></footer>`
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
