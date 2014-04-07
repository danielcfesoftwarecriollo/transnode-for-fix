library transnode.routes;

import 'package:angular/angular.dart';
import 'package:transnode/services/user_service.dart';
import 'package:transnode/services/messages_service.dart';
import 'dart:async';

class TransnodeRouterInitializer {
  UserService _userService;
  MessagesService _messagesService;
  Router _router;

  TransnodeRouterInitializer(this._userService, this._messagesService);
  
  void call(Router router, RouteViewFactory views) {
    _router = router;
    views.configure({
      'home': ngRoute(
          path: '/home',
          view: 'partials/home/index.html',
          defaultRoute: true,
          preEnter: authenticatedAccess),
      'login': ngRoute(
          path: '/login',
          view: 'partials/login/sign_in.html',
          preEnter: skipAuthenticatedAccess),
      'customer': ngRoute(
          path: '/customer',
          view: 'partials/customers/form.html',
          preEnter: authenticatedAccess),
      'shipment_order': ngRoute(
          path: '/shipment_order',
          view: 'partials/shipment_order/index.html',
          preEnter: authenticatedAccess)
    });
  }
  
  void authenticatedAccess(RoutePreEnterEvent e) {
    Future<bool> allow;
    if (!this._userService.isAuthenticated) {
      this._messagesService.add("We're sorry, but you need to login first");
      allow = new Future<bool>.value(false).whenComplete(() =>  _router.go("login",{}));
      e.allowEnter(allow);
    }
    else {
      allow = new Future<bool>.value(true);      
      e.allowEnter(allow);
    }   
  }
  
  void skipAuthenticatedAccess(RoutePreEnterEvent e) {
    if (this._userService.isAuthenticated) {
      e.allowEnter(new Future<bool>.value(false));
      _router.go("home",{});
    }
    else {
      e.allowEnter(new Future<bool>.value(true));
    }
  }
  
}

