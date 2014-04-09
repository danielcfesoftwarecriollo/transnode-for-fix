part of transnode;

@NgController(
    selector: '[shipment-order-controller]',
    publishAs: 'shipment_order_controller')
class ShipmentOrderController {
  ShipmentOrder shipment_order;

  ShipmentOrderController() {
    this.shipment_order = new ShipmentOrder();
  }
}
