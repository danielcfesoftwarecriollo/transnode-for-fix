part of transnode;

class TransnodeRouterInitializer {
  UserService _userService;
  MessagesService _messagesService;
  Router _router;

  TransnodeRouterInitializer(this._userService, this._messagesService);

  void call(Router router, views) {
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
      'customer_new_role': ngRoute(
          path: '/customers/new/:role',
          view: 'partials/customers/form.html',
          preEnter: authenticatedAccess),
      'customer_show': ngRoute(
          path: '/customers/:customerId',
          view: 'partials/customers/show.html',
          preEnter: authenticatedAccess),
      'customer_edit': ngRoute(
          path: '/customers/:customerId/edit',
          view: 'partials/customers/form.html',
          preEnter: authenticatedAccess),
      'location_add': ngRoute(
          path: 'locations/add/:customerId',
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
          }),
          'carriers': ngRoute(
              path: '/carriers',
              view: 'partials/carriers/index.html',
              preEnter: authenticatedAccess),
          'carrier_new': ngRoute(
              path: '/carriers/new',
              view: 'partials/carriers/form.html',
              preEnter: authenticatedAccess),
          'carrier_show': ngRoute(
              path: '/carriers/:carrierId',
              view: 'partials/carriers/show.html',
              preEnter: authenticatedAccess),
          'carrier_edit': ngRoute(
              path: '/carriers/:carrierId/edit',
              view: 'partials/carriers/form.html',
              preEnter: authenticatedAccess),
          'shipments': ngRoute(
              path: '/shipments',
              view: 'partials/shipments/index.html',
              preEnter: authenticatedAccess),
          'shipment_new': ngRoute(
              path: '/shipments/new',
              view: 'partials/shipments/form.html',
              preEnter: authenticatedAccess),
          'shipment_new_with_quote': ngRoute(
              path: '/shipments/new/:quoteId',
              view: 'partials/shipments/form.html',
              preEnter: authenticatedAccess),
          'shipment_show': ngRoute(
              path: '/shipments/:shipmentId',
              view: 'partials/shipments/show.html',
              preEnter: authenticatedAccess),
          'shipment_edit': ngRoute(
              path: '/shipments/:shipmentId/edit',
              view: 'partials/shipments/form.html',
              preEnter: authenticatedAccess),
          'quotes': ngRoute(
              path: '/quotes',
              view: 'partials/quotes/index.html',
              preEnter: authenticatedAccess),
          'quote_new': ngRoute(
              path: '/quotes/new',
              view: 'partials/quotes/form.html',
              preEnter: authenticatedAccess),
          'quote_show': ngRoute(
              path: '/quotes/:quoteId',
              view: 'partials/quotes/show.html',
              preEnter: authenticatedAccess),
          'quote_edit': ngRoute(
              path: '/quotes/:quoteId/edit',
              view: 'partials/quotes/form.html',
              preEnter: authenticatedAccess),
          'rfquotes': ngRoute(
              path: '/rfquotes',
              view: 'partials/rfquotes/index.html',
              preEnter: authenticatedAccess),
          'rfquote_new': ngRoute(
              path: '/rfquotes/new',
              view: 'partials/rfquotes/form.html',
              preEnter: authenticatedAccess),
          'rfquote_show': ngRoute(
              path: '/rfquotes/:rfquoteId',
              view: 'partials/rfquotes/show.html',
              preEnter: authenticatedAccess),
          'rfquote_edit': ngRoute(
              path: '/rfquotes/:rfquoteId/edit',
              view: 'partials/rfquotes/form.html',
              preEnter: authenticatedAccess),
          'search_clp': ngRoute(
              path: '/search_clp',
              view: 'partials/carriers/search_clp.html',
              preEnter: authenticatedAccess),
          'search_quote': ngRoute(
              path: '/search_quote',
              view: 'partials/quotes/search_quote.html',
              preEnter: authenticatedAccess),
          'invoice_preview': ngRoute(
              path: '/invoices/preview/:shipmentId',
              view: 'partials/invoices/preview.html',
              preEnter: authenticatedAccess),
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
