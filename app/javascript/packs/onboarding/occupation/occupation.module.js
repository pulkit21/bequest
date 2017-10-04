import angular from 'angular';
import occupationDirective from './occupation.directive';

let occupationModule = angular
  .module('occupationModule', [])
  .directive('occupation', occupationDirective)


export default occupationModule.name;
