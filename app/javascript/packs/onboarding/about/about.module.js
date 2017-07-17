import angular from 'angular';
import aboutDirective from './about.directive';

let aboutModule = angular
  .module('aboutModule', [])
  .directive('about', aboutDirective)

export default aboutModule.name;