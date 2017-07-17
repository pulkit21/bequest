import angular from 'angular';
import supportDirective from './support.directive';

let supportModule = angular
  .module('supportModule', [])
  .directive('support', supportDirective)

export default supportModule.name;