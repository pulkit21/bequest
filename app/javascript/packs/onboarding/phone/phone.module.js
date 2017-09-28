import angular from 'angular';
import phoneDirective from './phone.directive';

let phoneModule = angular
  .module('phoneModule', [])
  .directive('phone', phoneDirective)


export default phoneModule.name;
