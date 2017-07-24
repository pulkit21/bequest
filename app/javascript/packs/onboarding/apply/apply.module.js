import angular from 'angular';
import applyDirective from './apply.directive';

let applyModule = angular
  .module('applyModule', [])
  .directive('apply', applyDirective)


export default applyModule.name;
