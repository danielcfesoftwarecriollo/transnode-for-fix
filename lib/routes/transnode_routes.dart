part of transnode;

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
          preEnter: authenticatedAccess),
      'login': ngRoute(
          path: '/login',
          view: 'partials/login/sign_in.html',
          defaultRoute: true,
          preEnter: skipAuthenticatedAccess),
      'customers': ngRoute(
          path: '/customers',
          preEnter: authenticatedAccess,
          view: 'partials/customers/index.html'),
      'customer_new': ngRoute(
          path: '/customers/new',
          view: 'partials/customers/form.html',
          preEnter: authenticatedAccess),
      'customer_edit': ngRoute(
          path: '/customers/:customerId',
          view: 'partials/customers/form.html',
          preEnter: authenticatedAccess),
      'shipment_order': ngRoute(
          path: '/shipment_order',
          view: 'partials/shipment_order/index.html',
          preEnter: authenticatedAccess),
      'users': ngRoute(
          path: '/users',
          view: 'partials/users/index.html',
          preEnter: authenticatedAccess),
      'contact_list': ngRoute(
        path: '/contacts',
        preEnter: authenticatedAccess,
        mount: {
          'contact_list': ngRoute(
              path: '',
              view: 'partials/contacts/index.html'),
          'contact_new': ngRoute(
              path: '/new',
              view: 'partials/contacts/form.html'),
          'contact_show': ngRoute(
              path: '/show',
              view: 'partials/contacts/show.html'),
          'contact_edit': ngRoute(
              path: '/:contactId/edit',
              view: 'partials/contacts/form.html'),
        }),
       'user_resource': ngRoute(
          path: '/users/:userId',
          preEnter: authenticatedAccess,
          mount: {
            'user_list': ngRoute(
                path: '',
                view: 'partials/users/index.html'),
            'user_show': ngRoute(
                path: '/show',
                view: 'partials/users/show.html'),
            'user_edit': ngRoute(
                path: '/edit',
                view: 'partials/users/edit.html'),
          })
    });
  }

  void authenticatedAccess(RoutePreEnterEvent e) {
    Future<bool> allow;

    if (!this._userService.isAuthenticated) {
      this._messagesService.add('warning', "We're sorry, but you need to login first");

      allow = new Future<bool>.value(false).whenComplete(() =>  _router.go("login",{}));
    }
    else {
      allow = new Future<bool>.value(true);
    }

    e.allowEnter(allow);
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
