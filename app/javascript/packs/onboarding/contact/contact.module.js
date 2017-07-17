import angular from 'angular';
import contactDirective from './contact.directive';

let contactModule = angular
  .module('contactModule', [])
  .directive('contact', contactDirective);

export default contactModule.name;