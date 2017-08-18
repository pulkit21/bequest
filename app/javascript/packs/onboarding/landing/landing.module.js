import angular from 'angular';
import landingDirective from './landing.directive';

let landingModule = angular
  .module('landingModule', [])
  .directive('landing', landingDirective);

export default landingModule.name;
