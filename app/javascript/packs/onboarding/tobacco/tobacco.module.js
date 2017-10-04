import angular from 'angular';
import tobaccoDirective from './tobacco.directive';

let tobaccoModule = angular
  .module('tobaccoModule', [])
  .directive('tobacco', tobaccoDirective)


export default tobaccoModule.name;
