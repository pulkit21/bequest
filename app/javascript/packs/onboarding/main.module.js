import angular from 'angular';
import ngMaterial from 'angular-material';
import angularMaterialIcons from 'angular-material-icons';
// import 'style!css!angular-material/angular-material.css';
import 'angular-material/angular-material.css';
import 'angular-material/angular-material.js';


angular.module('bequest-landing', [
  ngMaterial,
  angularMaterialIcons
])

// .run(defaultModuleRun);

angular
  .bootstrap(document, ['bequest-landing']);
