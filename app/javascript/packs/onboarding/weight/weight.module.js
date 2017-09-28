import angular from 'angular';
import weightDirective from './weight.directive';

let weightModule = angular
  .module('weightModule', [])
  .directive('weight', weightDirective)


export default weightModule.name;
