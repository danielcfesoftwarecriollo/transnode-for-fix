library transnode;

import 'dart:async';
import 'dart:html';
import 'dart:convert';
import 'package:angular/angular.dart';
import 'package:angular/routing/module.dart';
import 'package:ctrl_alt_foo/keys.dart';
import "dart:mirrors"; 

part 'routes/transnode_routes.dart';
part 'services/api_service.dart';
part 'services/user_service.dart';
part 'services/contact_service.dart';
part 'services/messages_service.dart';
part 'services/custom_header.dart';
part 'services/location_service.dart';
part 'services/customer_service.dart';
part 'services/session_service.dart';
part 'services/users_service.dart';

part 'controllers/app_controller.dart';
part 'controllers/customer_controller.dart';
part 'controllers/contacts_controller.dart';
part 'controllers/login_controller.dart';
part 'controllers/messages_controller.dart';
part 'controllers/shipment_order_controller.dart';
part 'controllers/users_controller.dart';
part 'controllers/locations_list_controller.dart';
part 'controllers/location_controller.dart';

part 'models/record_model.dart';
part 'models/record_model_nested.dart';
part 'models/contact.dart';
part 'models/partner.dart';
part 'models/customer.dart';
part 'models/location.dart';
part 'models/shipment_order.dart';
part 'models/shipper.dart';
part 'models/user.dart';

part 'validators/validator.dart';
part 'validators/location.dart';
part 'validators/customer.dart';
part 'validators/contact.dart';

class TransnodeModule extends Module {
  TransnodeModule() {
    type(RouteInitializerFn, implementedBy: TransnodeRouterInitializer);

    factory(NgRoutingUsePushState,
        (_) => new NgRoutingUsePushState.value(false));

    type(HttpDefaultHeaders, implementedBy: HeadersWithToken);

    type(AppController);
    type(LoginController);
    type(ContactsController);
    type(MessagesController);
    type(ShipmentOrderController);
    type(CustomerController);
    type(UsersController);

    type(UserService);
    type(ApiService);
    type(MessagesService);
    type(SessionService);
    type(ContactService);
    type(CustomerService);
    type(UsersService);
  }
}

start() {
  ngBootstrap(module: new TransnodeModule());
}
