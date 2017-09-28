import angular from 'angular';
import coverageDirective from './coverage.directive';

let coverageModule = angular
  .module('coverageModule', [])
  .directive('coverage', coverageDirective)


export default coverageModule.name;
