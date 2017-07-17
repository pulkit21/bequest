import angular from 'angular';
import privacyDirective from './privacy.directive';

let privacyModule = angular
  .module('privacyModule', [])
  .directive('privacy', privacyDirective)

export default privacyModule.name;