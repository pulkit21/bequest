import angular from 'angular';
import uiRouter from 'angular-ui-router';

import ngMaterial from 'angular-material';
import angularMaterialIcons from 'angular-material-icons';
// import 'style!css!angular-material/angular-material.css';
import 'angular-material/angular-material.css';

import {defaultModuleConfig} from './app.module.config';
import landingModule from './landing/landing.module';
import quoteModule from './quote/quote.module';
import termsModule from './terms/terms.module';
import contactModule from './contact/contact.module';
import privacyModule from './privacy/privacy.module';
import learnModule from './learn/learn.module';
import compareModule from './compare/compare.module';
import aboutModule from './about/about.module';
import careersModule from './careers/careers.module';
import applyModule from './apply/apply.module';
import paymentModule from './payment/payment.module';
import supportModule from './support/support.module';
import pressModule from './press/press.module';
import signModule from './sign/sign.module';
import headerModule from './header/header.module';
import footerModule from './footer/footer.module';
import confirmModule from './confirm/confirm.module';
import registerModule from './register/register.module';
import bequestServices from './services/insurance.service';
import bequestController from './apply/apply.controller';
import bequestInterceptor from './services/insurance.interceptor';

angular.module('bdi-landing', [
  uiRouter,
  ngMaterial,
  angularMaterialIcons,
  landingModule,
  quoteModule,
  termsModule,
  contactModule,
  privacyModule,
  learnModule,
  compareModule,
  aboutModule,
  careersModule,
  applyModule,
  paymentModule,
  supportModule,
  pressModule,
  signModule,
  headerModule,
  footerModule,
  confirmModule,
  registerModule,
  bequestServices,
  bequestController,
  bequestInterceptor
])
.config(defaultModuleConfig)
// .run(defaultModuleRun);

angular
  .bootstrap(document, ['bdi-landing']);
