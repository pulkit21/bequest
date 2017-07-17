import angular from 'angular';
import registerDirective from './register.directive';

let registerModule = angular
  .module('registerModule', [])
  .directive('register', registerDirective)

export default registerModule.name;