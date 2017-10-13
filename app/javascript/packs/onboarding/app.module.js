
import uiRouter from 'angular-ui-router';
import {defaultModuleConfig} from './app.module.config';
import quoteModule from './quote/quote.module';
import productModule from './product/product.module';
import tobaccoModule from './tobacco/tobacco.module';
import historyModule from './history/history.module';
import bloodModule from './blood/blood.module';
import cholesterolModule from './cholesterol/cholesterol.module';
import familyHistoryModule from './familyHistory/familyHistory.module';
import occupationModule from './occupation/occupation.module';
import drivingModule from './driving/driving.module';
import alcoholModule from './alcohol/alcohol.module';
import genderModule from './gender/gender.module';
import birthdayModule from './birthday/birthday.module';
import heightModule from './height/height.module';
import weightModule from './weight/weight.module';
import streetModule from './street/street.module';
import phoneModule from './phone/phone.module';
import licenseModule from './license/license.module';
import coverageModule from './coverage/coverage.module';
import frequencyModule from './frequency/frequency.module';
import beneficiaryModule from './beneficiary/beneficiary.module';
import paymentModule from './payment/payment.module';
import signModule from './sign/sign.module';
import confirmModule from './confirm/confirm.module';
import bequestServices from './services/insurance.service';
import bequestController from './apply/apply.controller';
import bequestInterceptor from './services/insurance.interceptor';
import angularPayments from 'angular-payments';
import confirmController from './confirm/confirm.controller';
import deniedModule from './denied/denied.module';


import applyModule from './apply/apply.module';


angular.module('bdi-landing', [
  uiRouter,
  applyModule,
  quoteModule,
  productModule,
  tobaccoModule,
  historyModule,
  bloodModule,
  cholesterolModule,
  familyHistoryModule,
  occupationModule,
  drivingModule,
  alcoholModule,
  genderModule,
  birthdayModule,
  heightModule,
  weightModule,
  streetModule,
  phoneModule,
  licenseModule,
  coverageModule,
  frequencyModule,
  beneficiaryModule,
  deniedModule,


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
