import angular from 'angular';
import blogDirective from './blog.directive';

let blogModule = angular
  .module('blogModule', [])
  .directive('blog', blogDirective)

export default blogModule.name;