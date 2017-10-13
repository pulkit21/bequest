import angular from 'angular';
import deniedDirective from './denied.directive';

let deniedModule = angular
  .module('deniedModule', [])
  .directive('denied', deniedDirective)


export default deniedModule.name;
