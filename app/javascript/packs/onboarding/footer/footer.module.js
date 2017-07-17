import angular from 'angular';
import footerDirective from './footer.directive';

let footerModule = angular
  .module('footerModule', [])
  .directive('footer', footerDirective)

export default footerModule.name;