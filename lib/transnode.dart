library transnode;

import 'dart:async';
import 'dart:html';
import 'dart:convert';
import 'package:angular/angular.dart';
import 'package:angular/routing/module.dart';


part 'routes/transnode_routes.dart';

part 'services/api_service.dart';
part 'services/user_service.dart';
part 'services/messages_service.dart';
part 'services/custom_header.dart';
part 'services/customer_service.dart';
part 'services/session_service.dart';

part 'controllers/app_controller.dart';
part 'controllers/customer_controller.dart';
part 'controllers/login_controller.dart';
part 'controllers/messages_controller.dart';
part 'controllers/shipment_order_controller.dart';
part 'controllers/test_controller.dart';

part 'models/contact.dart';
part 'models/customer.dart';
part 'models/location.dart';
part 'models/shipment_order.dart';
part 'models/shipper.dart';

class TransnodeModule extends Module {
  TransnodeModule(){
    type(RouteInitializerFn, implementedBy: TransnodeRouterInitializer);

    factory(NgRoutingUsePushState,
        (_) => new NgRoutingUsePushState.value(false));

    type(HttpDefaultHeaders, implementedBy: HeadersWithToken);

    type(AppController);
    type(LoginController);
    type(MessagesController);
    type(ShipmentOrderController);
    type(CustomerController);
    type(TestController);

    type(UserService);
    type(ApiService);
    type(MessagesService);
    type(SessionService);
    type(CustomerService);
  }
}
start(){
  ngBootstrap(module: new TransnodeModule());
}
