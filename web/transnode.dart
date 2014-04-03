library transnode;

import 'package:angular/angular.dart';
import 'package:angular/routing/module.dart';
import 'package:di/di.dart';

import 'package:transnode/routes/transnode_routes.dart';

import 'package:transnode/controllers/app_controller.dart';
import 'package:transnode/controllers/messages_controller.dart';
import 'package:transnode/controllers/login_controller.dart';
import 'package:transnode/controllers/customer_controller.dart';
import 'package:transnode/controllers/shipment_order_controller.dart';

import 'package:transnode/services/api_service.dart';
import 'package:transnode/services/user_service.dart';
import 'package:transnode/services/messages_service.dart';
import 'package:transnode/services/session_service.dart';
import 'package:transnode/services/custom_header.dart';
import 'package:transnode/services/customer_service.dart';
import 'package:transnode/components/components.dart';

class TransnodeModule extends Module {
  TransnodeModule() {
    
    type(RouteInitializerFn, implementedBy: TransnodeRouterInitializer);

    factory(NgRoutingUsePushState,
        (_) => new NgRoutingUsePushState.value(false));

    type(HttpDefaultHeaders, implementedBy: HeadersWithToken);

    type(AppController);
    type(LoginController);
    type(MessagesController);
    type(ShipmentOrderController);
    type(CustomerController);

    type(UserService);
    type(ApiService);
    type(MessagesService);
    type(SessionService);
    type(CustomerService);
    type(ContactComponent);
  }
}

void main() {
  ngBootstrap(module: new TransnodeModule());
}
