import angular from 'angular';
import licenseDirective from './license.directive';

let licenseModule = angular
  .module('licenseModule', [])
  .directive('license', licenseDirective)


export default licenseModule.name;
