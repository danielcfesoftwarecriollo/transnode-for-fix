part of transnode;

@Controller(selector: '[shipment-controller]', publishAs: 'ctrl')
class ShipmentsController {
  RouteProvider _routeProvider;
  Router _router;
  final ShipmentService _shipmentService;
  List<Shipper> shippers;
  List consigne_locations;
  List consignees;
  List consignees_to_select;
  List shippers_to_select;
  int shipper_id;
  int consignee_id;
  int consigneeLocation_id;
  
  List customers;
  List billtos;
  List customsbrokers;

  Customer custombroker;
  Customer billto;
  Location billtoLocation;

  int step;
  @NgTwoWay("shipment")
  Shipment shipment;

  List<Shipment> shipments;
  

  String textForModal;
  String typeModal;
  Modal modal;
  ModalInstance modalInstance;
  
  Scope scope;

  Http _http;
  var asyncSelected;
  bool loadingLocations = false;
  
  String functionss = 'test()';

  ShipmentsController(this._http,this.scope, this.modal,this._shipmentService, this._routeProvider, this._router) {
    this.shipment = new Shipment();
    this.shipment.shippers = [];
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

  
  void load_form(){
    _shipmentService.loadForm().then((response){
      customers = response['customer'];
      consignees_to_select = response['customer'];
      shippers_to_select = response['customer'];
      customsbrokers = response['custom_brokers'];
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

// begin Autocomplete Customer
  
  load_customers(val) {
   return _http.post('http://localhost:3000/shipments/customers/'+val,'').then((response){
      return response.data['customers'];
    });
  }

  formated(model){
    print(model);
    return model['value'];
  }
  
  onSelect($item, $model, $label){
    var response = _shipmentService.load_customer($item['value'].toString());
    response.then((customerData){
      loadAllBillData(customerData);
    });
    return $model['value'];
  }

// End Autocomplete Customer


// begin shippers consignee Logic

  // void add_new_shipper(){
  //   this.shipment.shippers.add(new Shipper());
  // }

  void addSecondShipper(){
    if(! hasValidShipper()){
      add_new_shipper();
    }    
  }

  void change_shipper(shipper) {
    new Timer(const Duration(milliseconds: 1000), () {
      var response = this._shipmentService.load_consigneLocations(shipper.id);
      response.then((response) {
        print(response);
        shipper.locationsCustomer = response['locations'];
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

// End shippers consignee Logic

// Begin Modal Windows

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
    modalInstance.close(null);
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

  List <Location> loadLocationsWithJson(data){
    return data.map((attr) {
      Location l = new Location();
      l.loadWithJson(attr);
      return l;
    });
  }

  void changeBillTo(){
    var response = this._shipmentService.load_customer(this.consignee_id.toString());
    response.then((data) {
      _loadbillto(data['bill_to_location']['location']);
      _loadBilltoCustomer(data['bill_to_customer']);
    });
    modalInstance.close(null);
  }

  void addShipper(){
    var response = this._shipmentService.load_location(this.consigneeLocation_id);
    response.then((data) {
      Shipper s = new Shipper();
      Location l = new Location();
      l.loadWithJson(data['location']);
      s.locationCustomer = l;
      shipment.shippers.add(s);      
    });
    modalInstance.close(null);
  }

  void changeBillToModal(){
    new Timer(const Duration(milliseconds: 1000), () {
      var response = this._shipmentService.load_billToLocations(this.consignee_id);
      response.then((response) {
        this.consigne_locations = response['locations'];
      });
    });
  }

  void loadAllBillData(data){
    _loadbillto(data['bill_to_location']['location']);
    _loadBilltoCustomer(data['bill_to_customer']);
    _loadCustomsbroker(data['custom_broker']);
    _loadCustomer(data['customer']);    
  }

  void changeCustomsBroker(){
    var response = this._shipmentService.load_customer(this.consignee_id.toString());
    response.then((data) {
      _loadCustomsbroker(data['custom_broker']);
    });    
    modalInstance.close(null);
  }

  void open(String templateUrl) {
    modalInstance = modal.open(new ModalOptions(templateUrl:templateUrl),scope);
  }

  void modalAddShipper(){
    open('partials/shipments/modal/add_shipper.html');
  }

  void modalConsignee(){
    open('partials/shipments/modal/consignee_location.html');
  }

  void modalBillTo(){
    open('partials/shipments/modal/billto_location.html');
  }

  void modalCustomBroker(){
    open('partials/shipments/modal/customsbroker_location.html');
  }

// End Modal Windows

  void _loadCustomsbroker(data){
    Customer custombroker = new Customer();
    custombroker.loadWithJson(data);
    this.shipment.customsbroker = custombroker;
  }

  void _loadBilltoCustomer(data){
    Customer billto = new Customer();
    billto.loadWithJson(data);
    this.billto = billto;
  }

  void _loadbillto(data){
    Location location = new Location();
    location.loadWithJson(data);
    this.shipment.loadBillTo(location);
  }
  void _loadCustomer(data){
    Customer customer = new Customer();
    customer.loadWithJson(data);
    this.shipment.loadCustomer(customer);
  }


// to change
  bool internationalShipments() => true;
// 
  
  bool has_shippers() => this.shipment.shippers.isNotEmpty;
  // bool get has_consignees => this.consignees.isNotEmpty;
  bool otherCustomerInBillTo() => this.billto != null && this.billto.id != this.shipment.customerId;
  bool inStep(int step) => step == this.step;
  int toStep(int step) => this.step = step;
  bool hasConsigneeLocations() => this.consigne_locations.length > 0;
  bool hasMoreOneShipperLocations() => this.shipment.shippers.length > 1;
  bool hasValidShipper() => this.shipment.shippers.length > 1 || this.shipment.consignees.length > 1;
  bool hasValidConsignee() => this.shipment.consignees.length > 1 || this.shipment.consignees.length > 0 && this.shipment.shippers.length > 1;
  bool hasValidShipment() => hasValidShipper() && hasValidConsignee();
  bool _isEditPath() => _routeProvider.routeName == 'shipment_edit';
  bool _isNewPath() => _routeProvider.routeName == 'shipment_new';
  bool _isIndexPath() => _routeProvider.routeName == 'shipment_list';
}
