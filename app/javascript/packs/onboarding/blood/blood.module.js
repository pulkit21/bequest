import angular from 'angular';
import bloodDirective from './blood.directive';

let bloodModule = angular
  .module('bloodModule', [])
  .directive('blood', bloodDirective)


export default bloodModule.name;
