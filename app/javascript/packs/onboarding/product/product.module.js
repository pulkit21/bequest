import angular from 'angular';
import productDirective from './product.directive';

let productModule = angular
  .module('productModule', [])
  .directive('product', productDirective)


export default productModule.name;
