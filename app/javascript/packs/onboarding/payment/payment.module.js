import angular from 'angular';
import paymentDirective from './payment.directive';

let paymentModule = angular
  .module('paymentModule', [])
  .directive('payment', paymentDirective)

export default paymentModule.name;