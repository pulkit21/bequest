import angular from 'angular';
import streetDirective from './street.directive';

let streetModule = angular
  .module('streetModule', [])
  .directive('street', streetDirective)


export default streetModule.name;
