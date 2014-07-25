part of transnode;

//import 'data/user.dart' as data;


@NgController(selector: '[shipment-controller]', publishAs: 'ctrl')
class ShipmentsController {
  RouteProvider _routeProvider;
  Router _router;
  final ShipmentService _shipmentService;
  List customers;
  List billtos;
  List customsbrokers;
  List<Shipper> shippers;


  @NgTwoWay("shipment")
  Shipment shipment;
  List<Shipment> shipments;
  int  step;

  ShipmentsController(this._shipmentService, this._routeProvider, this._router) {
    this.shipment = new Shipment();
    this.step = 1;
    this.shippers = [new Shipper()];
    this.shippers.length;
   if (_isEditPath()) {
//     _shipmentService.get(_routeProvider.parameters['shipmentId']).then((_) => this.shipment = _);
    load_form();
   } else if (_isIndexPath()) {
     this.shipments = [];
   }
   else{
    load_form();
   }

  }

  bool inStep(int step) => step == this.step;  
  int toStep(int step) => this.step = step;

  void load_form(){
    _shipmentService.loadForm().then((response){
      customers = response['customer'];
      billtos = response['bill_tos'];
      customsbrokers = response['custom_brokers'];
      // shippers = response['shippers'];
      
    });
    // add events
    new Timer(const Duration(milliseconds: 1000), () {

    });    
  }
  void add_new_shipper(){
    this.shippers.add(new Shipper());
  }
  void addSecondShipper(){
    if(hasValidShipper()){
      add_new_shipper();
    }    
  }
  bool hasValidShipper() => this.shippers.length <= 1;
  
  
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
