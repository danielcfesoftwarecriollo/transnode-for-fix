import 'package:angular/angular.dart';
class TransnodeRouter implements RouteInitializer {
  init(Router router, ViewFactory view) {
    router.root
      ..addRoute(
          name: 'login',
          path: '/login',
          enter: view('partials/login/index.html'))
      ..addRoute(
          name: 'shipment_order',
          path: '/shipment_order',
          enter: view('partials/shipment_order/index.html'))
      ..addRoute(
          name: 'root',
          path: '/',
          defaultRoute: true,
          enter: view('partials/home/index.html'));
  }
}