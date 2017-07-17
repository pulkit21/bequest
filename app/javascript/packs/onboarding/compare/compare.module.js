import angular from 'angular';
import compareDirective from './compare.directive';

let compareModule = angular
  .module('compareModule', [])
  .directive('compare', compareDirective)

export default compareModule.name;