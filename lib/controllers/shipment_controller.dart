part of transnode;


// @Controller(selector: '[modal-ctrl-tmpl]', publishAs: 'ctrl')
// class ModalCtrlTemplate {

  
//   ModalCtrlTemplate();
  

// }



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
  int consignee_id;
  int consigneeLocation_id;

  @NgTwoWay("shipment")
  Shipment shipment;
  List<Shipment> shipments;
  int  step;

  List<String> items = ["1111", "2222", "3333", "4444"];
  String selected;
  String tmp;
  Modal modal;
  ModalInstance modalInstance;
  Scope scope;
  
  String template = """
<div class="modal-header">
  <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
  <h4 class="modal-title">I'm a modal! DANIEL</h4>
</div>
<div class="modal-body">
  <div style="padding: 10px" >

    <label class="title-label" for="lanecode">Consignee</label>
    <select ng-model='ctrl.consignee_id' ng-change="ctrl.change_consignee()" id="consignee" class="form-control">
      <option value="" disabled selected>Select consignee</option>
      <option ng-repeat='consignee in ctrl.consignees_to_select' ng-value='consignee[0]' ng-selected="consignee[0] == ctrl.consignee_id">{{consignee[1]}}</option>
    </select>

    <label class="title-label" for="lanecode">Location</label>
    <select ng-model='ctrl.consigneeLocation_id' id="location" class="form-control">
      <option value="" disabled selected>Select Location</option>
      <option ng-repeat='location in ctrl.consigne_locations' ng-value='location[0]' ng-selected="location[0] == ctrl.consigneeLocation_id">{{location[1]}}</option>
    </select>
    <button class="btn btn-primary" ng-click="ctrl.addConsignee()" >Add Consignee Location</button>
  </div>
</div>
<div class="modal-footer">
  <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
  <button type="button" class="btn btn-primary" ng-click="ctrl.ok(ctrl.tmp)">OK</button>
</div>
""";

  ShipmentsController(this.modal, this.scope,this._shipmentService, this._routeProvider, this._router) {
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
      selected = result;
      print('Closed with selection $selected');
      modal.hide();
    };
    // Override dismiss to add you own functionality 
    modalInstance.dismiss = (String reason) { 
      print('Dismissed with $reason');
      modal.hide();
   };
  }
  
  void ok(sel) {
    modalInstance.close(sel);
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
