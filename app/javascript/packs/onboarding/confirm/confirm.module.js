import angular from 'angular';
import confirmDirective from './confirm.directive';

let confirmModule = angular
  .module('confirmModule', [])
  .directive('confirm', confirmDirective)

export default confirmModule.name;