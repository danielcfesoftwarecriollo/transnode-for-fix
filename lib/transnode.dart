library transnode;

import 'dart:async';
import 'dart:html';
import 'dart:convert';
//import 'dart:html' as dom;
import 'dart:math' as math;
import 'package:polymer/polymer.dart';


import 'package:angular_ui/utils/injectable_service.dart';
import 'package:angular_ui/angular_ui.dart';
import 'package:angular_ui/utils/utils.dart';
import 'package:angular_node_bind/angular_node_bind.dart' show NodeBindModule;
import 'package:html_components/html_components.dart' show DatatableComponent, GrowlComponent;
import 'package:angular/angular.dart';
import 'package:html_components/data/datatable/data.dart';


import 'package:angular/routing/module.dart';
import 'package:ctrl_alt_foo/keys.dart';
import "dart:mirrors"; 
import 'package:model_map/model_map.dart';
import 'package:angular/application_factory.dart';


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
part 'services/quote_service.dart';
part 'services/city_service.dart';
part 'services/mail_service.dart';
part 'services/exchange_rate_service.dart';
part 'services/exchange_rate_factor_service.dart';

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
part 'controllers/quotes_controller.dart';
part 'controllers/rfquotes_controller.dart';
part 'controllers/searchclp_controller.dart';

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
part 'models/note.dart';
part 'models/quote.dart';
part 'models/rfquote.dart';
part 'models/shipment_carrier.dart';
part 'models/revenue_cost.dart';
part 'models/revenue.dart';
part 'models/cost.dart';
part 'models/mail.dart';
part 'models/quote_cost.dart';
part 'models/exchange_rate.dart';
part 'models/rating.dart';
part 'models/exchange_rate_factor.dart';
part 'models/invoice.dart';

part 'models/helpers/helper_list.dart';
part 'models/helpers/helper_url.dart';
part 'models/helpers/helper_load_model.dart';
part 'models/helpers/carrier_price.dart';
part 'models/helpers/exchange_value.dart';

part 'validators/validator.dart';
part 'validators/location.dart';
part 'validators/customer.dart';
part 'validators/carrier.dart';
part 'validators/contact.dart';
part 'validators/price.dart';
part 'validators/city.dart';
part 'validators/lane.dart';
part 'validators/quote.dart';
part 'validators/shipment.dart';
part 'validators/line.dart';
part 'validators/note.dart';
part 'validators/shipment_carrier.dart';
part 'validators/shipment_consignee.dart';
part 'validators/shipment_shipper.dart';
part 'validators/revenue_cost.dart';
part 'validators/quote_cost.dart';
part 'validators/exchange_rate.dart';

class TransnodeModule extends Module {

  TransnodeModule() {
    type(RouteInitializerFn, implementedBy: TransnodeRouterInitializer);
    factory(NgRoutingUsePushState,(_) => new NgRoutingUsePushState.value(false));
    type(HttpDefaultHeaders, implementedBy: HeadersWithToken);

    install(new AngularUIModule());
    
    bind(AppController);
    bind(LoginController);
    bind(ContactsController);
    bind(MessagesController);
    bind(ShipmentOrderController);
    bind(ShipmentsController);
    bind(CustomerController);
    bind(CarrierController);
    bind(UsersController);
    bind(QuotesController);
    bind(RfquotesController);
    bind(SearchclpController);
    
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
    bind(QuoteService);
    bind(CityService);
    bind(MailService);
    bind(ExchangeRateService);
    bind(ExchangeRateFactorService);
  }
}

@initMethod
start() {
  initPolymer().run((){
    applicationFactory()
    .addModule(new TransnodeModule())
    .addModule(new NodeBindModule()).run();
    
  });
}
