import angular from 'angular';
import termsDirective from './terms.directive';

let termsModule = angular
  .module('termsModule', [])
  .directive('terms', termsDirective)

export default termsModule.name;