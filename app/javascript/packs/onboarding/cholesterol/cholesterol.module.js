import angular from 'angular';
import cholesterolDirective from './cholesterol.directive';

let cholesterolModule = angular
  .module('cholesterolModule', [])
  .directive('cholesterol', cholesterolDirective)


export default cholesterolModule.name;
