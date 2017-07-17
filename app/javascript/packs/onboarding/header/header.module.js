import angular from 'angular';
import headerDirective from './header.directive';

let headerModule = angular
  .module('headerModule', [])
  .directive('header', headerDirective)

export default headerModule.name;