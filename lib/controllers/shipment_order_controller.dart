library transnode.shipment_order_controller;

import 'package:angular/angular.dart';
import 'package:transnode/models/shipment_order.dart' show ShipmentOrder;

@NgController(
    selector: '[shipment-order-controller]',
    publishAs: 'shipment_order_controller')

class ShipmentOrderController {
  ShipmentOrder shipment_order = new ShipmentOrder();

  ShipmentOrderController(){
    this.shipment_order = new ShipmentOrder();
  }
}