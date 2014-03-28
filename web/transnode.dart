library transnode;

import 'package:angular/angular.dart';

import 'package:transnode/routes/transnode_routes.dart';

import 'package:transnode/controllers/app_controller.dart';
import 'package:transnode/controllers/customer_controller.dart';
import 'package:transnode/controllers/login_controller.dart';
import 'package:transnode/controllers/shipment_order_controller.dart';

import 'package:transnode/services/api_service.dart';
import 'package:transnode/services/customer_service.dart';
import 'package:transnode/services/user_service.dart';
import 'package:transnode/services/custom_header.dart';
import 'package:transnode/services/session_services.dart';

import 'package:transnode/components/components.dart';

@MirrorsUsed(override: '*')
import 'dart:mirrors';

class TransnodeModule extends Module {
  TransnodeModule() {
    type(RouteInitializer, implementedBy: TransnodeRouter);
    type(NgRoutingHelper);

    type(AppController);
    type(LoginController);
    type(ShipmentOrderController);
    type(CustomerController);

    type(User);
    type(ApiService);
    type(SessionService);
    type(CustomerService);

    type(HttpDefaultHeaders, implementedBy: CustomHeader);
    type(ContactComponent);
    factory(NgRoutingUsePushState, (_) => new NgRoutingUsePushState.value(false)
        );
  }
}

void main() {
  ngBootstrap(module: new TransnodeModule());
}
