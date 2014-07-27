library transnode;

import 'dart:async';
 import 'dart:html';
import 'dart:convert';
//import 'dart:html' as dom;
import 'dart:math' as math;
// import 'package:polymer/polymer.dart';
// import 'package:html_components/html_components.dart' show DialogComponent, GrowlComponent;
// import 'data/user.dart' as data;

import 'package:angular_ui/utils/extend.dart';
import 'package:angular_ui/utils/injectable_service.dart';

import 'package:angular/angular.dart';
import 'package:angular/routing/module.dart';
import 'package:ctrl_alt_foo/keys.dart';
import "dart:mirrors"; 


import 'package:angular/application_factory.dart';
import 'package:angular_ui/angular_ui.dart';
import 'package:angular_ui/utils/utils.dart';

part 'component/rating/rating_component.dart';

part 'routes/transnode_routes.dart';
part 'services/api_service.dart';
part 'services/user_service.dart';
part 'services/contact_service.dart';
part 'services/messages_service.dart';
part 'services/custom_header.dart';
part 'services/location_service.dart';
part 'services/customer_service.dart';
part 'services/carrier_service.dart';
part 'services/shipment_service.dart';
part 'services/session_service.dart';
part 'services/users_service.dart';

part 'controllers/app_controller.dart';
part 'controllers/customer_controller.dart';
part 'controllers/carrier_controller.dart';
part 'controllers/contacts_controller.dart';
part 'controllers/login_controller.dart';
part 'controllers/messages_controller.dart';
part 'controllers/shipment_controller.dart';
part 'controllers/shipment_order_controller.dart';
part 'controllers/users_controller.dart';
part 'controllers/locations_list_controller.dart';
part 'controllers/location_controller.dart';

part 'models/record_model.dart';
part 'models/record_model_nested.dart';
part 'models/contact.dart';
part 'models/entity.dart';
part 'models/lane.dart';
part 'models/price.dart';
part 'models/customer.dart';
part 'models/carrier.dart';
part 'models/location.dart';
part 'models/shipment.dart';
part 'models/line.dart';
part 'models/shipper.dart';
part 'models/consignee.dart';
part 'models/user.dart';
part 'models/city.dart';

part 'validators/validator.dart';
part 'validators/location.dart';
part 'validators/customer.dart';
part 'validators/carrier.dart';
part 'validators/contact.dart';
part 'validators/price.dart';
part 'validators/city.dart';
part 'validators/lane.dart';


class TransnodeModule extends Module {

  TransnodeModule() {
    type(RouteInitializerFn, implementedBy: TransnodeRouterInitializer);
    factory(NgRoutingUsePushState,(_) => new NgRoutingUsePushState.value(false));
    type(HttpDefaultHeaders, implementedBy: HeadersWithToken);

    install(new AngularUIModule());
    //
//    bind(ModalCtrlTemplate);

    bind(AppController);
    bind(LoginController);
    bind(ContactsController);
    bind(MessagesController);
    bind(ShipmentOrderController);
    bind(ShipmentsController);
    bind(CustomerController);
    bind(CarrierController);
    bind(UsersController);
    
    bind(RatingComponent);

    bind(UserService);
    bind(ApiService);
    bind(ShipmentService);
    bind(MessagesService);
    bind(SessionService);
    bind(ContactService);
    bind(CustomerService);
    bind(CarrierService);
    bind(UsersService);
  }
}

start() {
//  ngBootstrap(module: new TransnodeModule());
  applicationFactory()
    .addModule(new TransnodeModule())
    .run();
}
