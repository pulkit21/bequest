import angular from 'angular';
import birthdayDirective from './birthday.directive';

let birthdayModule = angular
  .module('birthdayModule', [])
  .directive('birthday', birthdayDirective)


export default birthdayModule.name;
