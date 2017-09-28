import angular from 'angular';
import genderDirective from './gender.directive';

let genderModule = angular
  .module('genderModule', [])
  .directive('gender', genderDirective)


export default genderModule.name;
