import angular from 'angular';
import pressDirective from './press.directive';

let pressModule = angular
  .module('pressModule', [])
  .directive('press', pressDirective)

export default pressModule.name;