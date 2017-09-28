import angular from 'angular';
import drivingDirective from './driving.directive';

let drivingModule = angular
  .module('drivingModule', [])
  .directive('driving', drivingDirective)


export default drivingModule.name;
