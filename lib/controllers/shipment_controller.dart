part of transnode;

@Controller(selector: '[shipment-controller]', publishAs: 'ctrl')
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
  List shippers_to_select;
  int shipper_id;
  int consignee_id;
  int consigneeLocation_id;

  @NgTwoWay("shipment")
  Shipment shipment;
  List<Shipment> shipments;
  int  step;
  Modal modal;
  ModalInstance modalInstance;
  Scope scope;
  

  Http _http;
  var selected;
  var asyncSelected;
  var customSelected;

  bool loadingLocations = false;
  
  String template = """
<div class="modal-header">
  <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
  <h4 class="modal-title">Add New Consignee</h4>
</div>
<div class="modal-body">
  <div style="padding: 10px" >

    <label class="title-label" for="lanecode">Consignee</label>
    <select ng-model='ctrl.consignee_id' ng-change="ctrl.change_consignee()" id="consignee" class="form-control">
      <option value="" disabled selected>Select consignee</option>
      <option ng-repeat='consignee in ctrl.consignees_to_select' ng-value='consignee[0]' ng-selected="consignee[0] == ctrl.consignee_id">{{consignee[1]}}</option>
    </select>



    <label class="title-label" for="lanecode">Location</label>
    <select ng-disabled="! ctrl.hasConsigneeLocations()" ng-model='ctrl.consigneeLocation_id' id="location" class="form-control">
      <option value="" disabled selected>Select Location</option>
      <option ng-repeat='location in ctrl.consigne_locations' ng-value='location[0]' ng-selected="location[0] == ctrl.consigneeLocation_id">{{location[1]}}</option>
    </select>
  </div>
</div>
<div class="modal-footer">
  <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
  <button type="button" class="btn btn-primary" ng-click="ctrl.ok(null)">OK</button>
</div>
""";

  ShipmentsController(this._http, this.modal, this.scope,this._shipmentService, this._routeProvider, this._router) {
    this.shipment = new Shipment();
    this.shipment.shippers = [new Shipper()];
    this.shipment.consignees = [];

    this.step = 1;
    this.consigne_locations = [];
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

  void load_customers(val) {
    _shipmentService.load_customers().then((response){
      print(res);
    });
  }

  ModalInstance getModalInstance() {
    return modal.open(new ModalOptions(template:template), scope);
  }
  
  void open() {
    modalInstance = getModalInstance();
    
    modalInstance.opened
      ..then((v) {
        print('Opened');
      }, onError: (e) {
        print('Open error is $e');
      });
    
    // Override close to add you own functionality 
    modalInstance.close = (result) {
      print(result);
      modal.hide();
    };
    // Override dismiss to add you own functionality 
    modalInstance.dismiss = (String reason) { 
      print('Dismissed with $reason');
      modal.hide();
   };
  }
  
  void ok(result) {
    addConsignee();
    modalInstance.close(result);
  }

  bool inStep(int step) => step == this.step;
  int toStep(int step) => this.step = step;

  void load_form(){
    _shipmentService.loadForm().then((response){
      customers = response['customer'];
      consignees_to_select = response['customer'];
      shippers_to_select = response['customer'];
      billtos = response['bill_tos'];
      customsbrokers = response['custom_brokers'];
    });
    // add events
    new Timer(const Duration(milliseconds: 1000), () {

    });
  }

  void add_new_shipper(){
    this.shipment.shippers.add(new Shipper());
  }

  void addSecondShipper(){
    if(! hasValidShipper()){
      add_new_shipper();
    }    
  }
  
  void addConsignee() {
    if(this.consigneeLocation_id != null){
      var response = this._shipmentService.load_location(consigneeLocation_id);
      Location location = new Location();
      response.then((data){
        location.loadWithJson(data['location']);
        Consignee consignee = new Consignee();
        consignee.consigneeName =  data['consignee'];
        consignee.locationCustomer = location;
        this.shipment.consignees.add(consignee);
        return true;
      }).catchError((e) => false);
    }
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

  void change_shipper() {
    new Timer(const Duration(milliseconds: 1000), () {
      // var response = this._shipmentService.load_consigneLocations(this.consignee_id);
      response.then((response) {
        print(response);
        // this.consigne_locations = response['locations'];
      });
    });
  }

  void change_line(Line line) {
    new Timer(const Duration(milliseconds: 1000), () {
      Consignee consignee = this.shipment.consignees.firstWhere((e)=> e.locationCustomer.id == line.consigneId);
      consignee.lines.add(line);
    });
  }

  void deleteLine(Line element){
    element.delete();
  }
  
  void deleteConsignee(Consignee consignee){
    // this.shipment.consignee
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
  
  bool get has_shippers => this.shippers.isNotEmpty;
  bool get has_consignees => this.consignees.isNotEmpty;
  bool hasConsigneeLocations() => this.consigne_locations.length > 0;
  bool hasValidShipper() => this.shipment.shippers.length > 1 || this.shipment.consignees.length > 1;
  bool hasValidConsignee() => this.shipment.consignees.length > 1 || this.shipment.consignees.length > 0 && this.shipment.shippers.length > 1;
  bool hasValidShipment() => hasValidShipper() && hasValidConsignee();
  bool _isEditPath() => _routeProvider.routeName == 'shipment_edit';
  bool _isNewPath() => _routeProvider.routeName == 'shipment_new';
  bool _isIndexPath() => _routeProvider.routeName == 'shipment_list';
}
