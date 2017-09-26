import angular from 'angular';
import historyDirective from './history.directive';

let historyModule = angular
  .module('historyModule', [])
  .directive('history', historyDirective)


export default historyModule.name;
