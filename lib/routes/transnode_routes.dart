library transnode.routes;

import 'package:angular/angular.dart';
import 'package:transnode/services/user_service.dart';
import 'package:transnode/services/messages_service.dart';

class TransnodeRouterInitializer {
  UserService _userService;
  MessagesService _messagesService;
  TransnodeRouterInitializer(this._userService, this._messagesService);
  Router _router;
  void call(Router router, RouteViewFactory views) {
    _router = router;
    views.configure({
      'home': ngRoute(
          path: '/home',
          view: 'partials/home/index.html',
          preEnter:authenticatedAccess),
      'login': ngRoute(
          path: '/login',
          view: 'partials/login/sign_in.html',
          defaultRoute: true,
          preEnter:skipAuthenticatedAccess),
      'customer': ngRoute(
          path: '/customer',
          view: 'partials/customers/form.html',
          preEnter:authenticatedAccess),
      'shipment_order': ngRoute(
          path: '/shipment_order',
          view: 'partials/shipment_order/index.html',
          preEnter:authenticatedAccess)
    });
  }
  authenticatedAccess(RoutePreEnterEvent e) {
    if (!this._userService.isAuthenticated) {
      this._messagesService.add("We're sorry, but you need to login first");
      _router.gotoUrl("/");
    }
  }
  skipAuthenticatedAccess(RoutePreEnterEvent e) {
    if (this._userService.isAuthenticated) {
      _router.gotoUrl("/home");
    }
  }
}

