import angular from 'angular';
import alcoholDirective from './alcohol.directive';

let alcoholModule = angular
  .module('alcoholModule', [])
  .directive('alcohol', alcoholDirective)


export default alcoholModule.name;
