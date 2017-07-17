import angular from 'angular';
import quoteDirective from './quote.directive';

let quoteModule = angular
  .module('quoteModule', [])
  .directive('quote', quoteDirective)

export default quoteModule.name;