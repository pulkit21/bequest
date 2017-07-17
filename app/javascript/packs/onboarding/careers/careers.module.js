import angular from 'angular';
import careersDirective from './careers.directive';

let careersModule = angular
  .module('careersModule', [])
  .directive('careers', careersDirective);

export default careersModule.name;