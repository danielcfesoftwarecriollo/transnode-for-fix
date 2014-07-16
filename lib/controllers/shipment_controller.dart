part of transnode;

@NgController(selector: '[shipment-controller]', publishAs: 'ctrl')
class ShipmentsController {
  RouteProvider _routeProvider;
  Router _router;
  final ShipmentService _shipmentService;

  @NgTwoWay("shipment")
  Shipment shipment;
  List<Shipment> shipments;

  ShipmentsController(this._shipmentService, this._routeProvider, this._router) {
    this.shipment = new Shipment();

   if (_isEditPath()) {
     _shipmentService.get(_routeProvider.parameters['shipmentId']).then((_) =>
         this.shipment = _);
     load_form();
   } else if (_isIndexPath()) {
     this.shipments = [];
   }
   else{
     load_form();
   }

  }

  void load_form(){
    _shipmentService.loadForm().then((response){

    });
    // add events
    new Timer(const Duration(milliseconds: 1000), () {

    });    
  }

  void save() {
    if (this.shipment.is_valid()) {
      var response = this._shipmentService.save(this.shipment);
      response.then((HttpResponse response) {
        if (response == null) return false;
        _router.go('shipment_list', {});
      });
    }
  }

  bool _isEditPath() => _routeProvider.routeName == 'shipment_edit';
  bool _isNewPath() => _routeProvider.routeName == 'shipment_new';
  bool _isIndexPath() => _routeProvider.routeName == 'shipment_list';
}
