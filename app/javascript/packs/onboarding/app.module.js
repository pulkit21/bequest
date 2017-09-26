
import uiRouter from 'angular-ui-router';
import {defaultModuleConfig} from './app.module.config';
import quoteModule from './quote/quote.module';
import productModule from './product/product.module';
import tobaccoModule from './tobacco/tobacco.module';
import historyModule from './history/history.module';
import applyModule from './apply/apply.module';
import paymentModule from './payment/payment.module';
import signModule from './sign/sign.module';
import confirmModule from './confirm/confirm.module';
import bequestServices from './services/insurance.service';
import bequestController from './apply/apply.controller';
import bequestInterceptor from './services/insurance.interceptor';
import angularPayments from 'angular-payments';
import confirmController from './confirm/confirm.controller';


angular.module('bdi-landing', [
  uiRouter,
  applyModule,
  quoteModule,
  productModule,
  tobaccoModule,
  historyModule,
  paymentModule,
  signModule,
  confirmModule,
  bequestServices,
  bequestController,
  bequestInterceptor,
  "angularPayments",
  confirmController
])
.config(defaultModuleConfig)

// .run(defaultModuleRun);

// angular
//   .bootstrap(document, ['bdi-landing']);

window.MODULES = window.MODULES || []
window.MODULES.push('bdi-landing');
