import angular from 'angular';
import familyHistoryDirective from './familyHistory.directive';

let familyHistoryModule = angular
  .module('familyHistoryModule', [])
  .directive('familyHistory', familyHistoryDirective)


export default familyHistoryModule.name;
