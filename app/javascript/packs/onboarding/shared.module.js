import angular from 'angular';
import ngMaterial from 'angular-material';
import angularMaterialIcons from 'angular-material-icons';
// import 'style!css!angular-material/angular-material.css';
import 'angular-material/angular-material.css';
import 'angular-material/angular-material.js';
import landingModule from './landing/landing.module';

window.MODULES = window.MODULES || []
var modules = [
  ngMaterial,
  angularMaterialIcons,
  landingModule
].concat(window.MODULES)

angular.module('bequest-landing', modules)

// .run(defaultModuleRun);

angular
  .bootstrap(document, ['bequest-landing']);
