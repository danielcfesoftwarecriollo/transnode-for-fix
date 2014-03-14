library transnode.shipment_order_controller;

import 'package:angular/angular.dart';

@NgController(
    selector: '[shipment-order]',
    publishAs: 'shipment_order')

class ShipmentOrderController {
  String text ="no";

  ShipmentOrderController(){
    this.text="ok";
  }
  String other(){
    return this.text;
  }

}