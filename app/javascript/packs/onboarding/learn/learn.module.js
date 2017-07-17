import angular from 'angular';
import learnDirective from './learn.directive';

let learnModule = angular
  .module('learnModule', [])
  .directive('learn', learnDirective)

export default learnModule.name;