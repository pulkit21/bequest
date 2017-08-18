import angular from 'angular';
import ngMaterial from 'angular-material';
import angularMaterialIcons from 'angular-material-icons';
// import 'style!css!angular-material/angular-material.css';
import 'angular-material/angular-material.css';
import 'angular-material/angular-material.js';
import landingModule from './landing/landing.module';
import Raven from 'raven-js';
import ravenAngularPlugin from 'raven-js/dist/plugins/angular.js';


Raven
  .config('https://bcefe27df82e4f8786d927c6c2a668dd@sentry.io/204497')
  .addPlugin(ravenAngularPlugin, angular)
  .install();
// Raven.addPlugin(ravenAngularPlugin, angular);

window.MODULES = window.MODULES || []
var modules = [
  ngMaterial,
  angularMaterialIcons,
  landingModule,
].concat(window.MODULES)


angular.module('bequest-landing', modules)


// .run(defaultModuleRun);

angular
  .bootstrap(document, ['bequest-landing']);
