part of transnode;

@NgController(selector: '[shipment-controller]', publishAs: 'ctrl')
class ShipmentsController {
  RouteProvider _routeProvider;
  Router _router;
  final ShipmentService _shipmentService;
  List customers;
  List billtos;
  List customsbrokers;
  List<Shipper> shippers;
  List consigne_locations;
  List consignees;
  List consignees_to_select;
  int consignee_id;
  int consigneeLocation_id;


  @NgTwoWay("shipment")
  Shipment shipment;
  List<Shipment> shipments;
  int  step;

  ShipmentsController(this._shipmentService, this._routeProvider, this._router) {
    this.shipment = new Shipment();
    this.step = 1;
    this.shippers = [new Shipper()];
    this.consignees = [];
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
      consignees_to_select = response['customer'];
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
    if(! hasValidShipper()){
      add_new_shipper();
    }    
  }
  bool hasValidShipper() => this.shippers.length > 1 || this.consignees.length > 1;
  bool hasValidConsignee() => this.consignees.length > 1 || this.consignees.length > 0 && this.shippers.length > 1;
  bool hasValidShipment() => hasValidShipper() && hasValidConsignee();
  
  bool addConsignee() {
    if(this.consigneeLocation_id != null){
      var response = this._shipmentService.load_location(consigneeLocation_id);
      Location location = new Location();
      response.then((data){
        location.loadWithJson(data['location']);
        Consignee consignee = new Consignee();
        consignee.consigneeName =  data['consignee'];
        consignee.locationCustomer = location;
        this.consignees.add(consignee);
        return true;
      }); 
      return false;
    }
    return false;
  }

  void change_consignee() {
    new Timer(const Duration(milliseconds: 1000), () {
      var response = this._shipmentService.load_consigneLocations(this.consignee_id);
      response.then((response) {
        print(response);
        this.consigne_locations = response['locations'];
      });
    });
  }

  void change_line(Line line) {
    new Timer(const Duration(milliseconds: 1000), () {
      Consignee consignee = this.consignees.firstWhere((e)=> e.id == line.consigneId);
      consignee.lines.add(line);
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
