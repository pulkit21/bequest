import angular from 'angular';
import beneficiaryDirective from './beneficiary.directive';

let beneficiaryModule = angular
  .module('beneficiaryModule', [])
  .directive('beneficiary', beneficiaryDirective)


export default beneficiaryModule.name;
