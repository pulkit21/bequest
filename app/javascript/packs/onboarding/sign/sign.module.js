import angular from 'angular';
import signDirective from './sign.directive';

let signModule = angular
  .module('signModule', [])
  .directive('sign', signDirective)

export default signModule.name;