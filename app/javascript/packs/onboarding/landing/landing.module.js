import angular from 'angular';
import landingDirective from './landing.directive';
// import headerDirective from '../header/header.directive';

let landingModule = angular
  .module('landingModule', [])
  .directive('landing', landingDirective);
  // .directive('header', headerDirective);

export default landingModule.name;
