import angular from 'angular';
import frequencyDirective from './frequency.directive';

let frequencyModule = angular
  .module('frequencyModule', [])
  .directive('frequency', frequencyDirective)


export default frequencyModule.name;
