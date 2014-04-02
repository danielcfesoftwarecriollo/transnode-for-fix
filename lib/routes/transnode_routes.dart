library transnode.routes;

import 'package:angular/angular.dart';

transnodeRouterInitializer(Router router, RouteViewFactory views) {
  views.configure({
    'root': ngRoute(
        path: '/',
        view: 'partials/home/index.html'),
    'login': ngRoute(
        path: '/login',
        view: 'partials/login/sign_in.html',
        defaultRoute: true),
    'customer': ngRoute(
        path: '/customer',
        view: 'partials/customers/form.html'),
    'shipment_order': ngRoute(
        path: '/shipment_order',
        view: 'partials/shipment_order/index.html')
  });
}
