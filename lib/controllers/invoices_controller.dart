part of transnode;

@Controller(selector: '[invoice-controller]', publishAs: 'ctrl')
class InvoiceController {
  @NgTwoWay("invoice")
  Contact invoice;
  @NgTwoWay("invoices")
  List<Contact> invoices;
  RouteProvider _routeProvider;
  Router _router;
  final ShipmentService _shipmentService;
  Shipment shipment;

  InvoiceController(this._shipmentService, this._routeProvider, this._router) {
    var shipment_id = _routeProvider.parameters['shipmentId'];
      _shipmentService.get(shipment_id).then((_){
        this.shipment = _;
      });
  }
}
