import angular from 'angular';
import heightDirective from './height.directive';

let heightModule = angular
  .module('heightModule', [])
  .directive('height', heightDirective)


export default heightModule.name;
