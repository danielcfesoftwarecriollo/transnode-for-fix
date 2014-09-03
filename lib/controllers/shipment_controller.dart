part of transnode;

@Controller(selector: '[shipment-controller]', publishAs: 'ctrl')
class ShipmentsController {
  static final String defaultCurrency = "CAD";
  RouteProvider _routeProvider;
  Router _router;
  ExchangeValue _exchange;
  final ShipmentService _shipmentService;
  final CarrierService _carrierService;
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
  RevenueCost rclineHelper;
  Customer rclineHelperCustomer;
  Map helperTotal;

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

  ShipmentsController(this._http,this.scope, this.modal,this._shipmentService, this._carrierService, this._routeProvider, this._router) {
    this.shipment = new Shipment();
    this._exchange = new ExchangeValue();
    this.step = 2;    
    this.consigne_locations = [];
    this.helperTotal = {'amount': 0.0, 'amountRevCa': 0.0, 'amountCostCa': 0.0, 'profit': 0.0 };
    if (_isEditPath()) {
      var shipment_id = _routeProvider.parameters['shipmentId'];
      _shipmentService.get(shipment_id).then((_){ 
        this.shipment = _;
        checkTotalRevCosts();
      });
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
      response.then((response) {
        if (response == null) return false;
        this.update_shipment(response);
      });
    }
  }
  void update_shipment( response ){
    if(response.data.length > 0){
      Shipment s = this._shipmentService._loadShipment(response.data);
      this.shipment = s;
    }
  }
  
  
// begin Autocomplete Customer
  
  loadCarriersByString(val){
    var response = this._carrierService.getCarriersByName(val.toString());
    return response.then((r) =>r);
  }
  
  load_customers(val) {   
   return _http.post('http://127.0.0.1:3000/shipments/customers/'+val,'').then((response){
      return response.data['customers'];
    });
  }
  

  onSelect($item, $model, $label){
    var response = _shipmentService.load_customer($item['value'].toString());
    response.then((customerData){
      loadAllBillData(customerData);
    });
    return $model['value'];
  }

  onSelectCarrier(ShipmentCarrier sCarrier,$item){
    var response = this._carrierService.get($item['value'].toString());
    response.then((_)=>sCarrier.carrier = _);
  }
// End Autocomplete Customer

// begin shippers consignee Logic
  void change_line(Line line) {
    new Timer(const Duration(milliseconds: 1000), () {
      this.shipment.addLineToConsignee(line);
    });
  }

  void deleteLine(Line l){
    l.delete();
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

  void editRCline(RevenueCost rcLine){
    this.rclineHelper = rcLine;
    changeRevCost(rcLine);
    open('partials/shipments/modal/add_rc_line.html');
  }
  
  void loadRCLineWithCustomer(RevenueCost rc, Customer c){
    rc.currency = c.currency;
  }

  void onSelectRCLine(itemSelected){
    var response = _shipmentService.load_customer(itemSelected['value'].toString());
    response.then((customerData){
      Customer cToBillTo = new Customer();
      cToBillTo.loadWithJson(customerData['customer']);
      this.rclineHelperCustomer = cToBillTo;
      loadRCLineWithCustomer(this.rclineHelper, cToBillTo);
    });
  }

  void addRCLine(){
    this.rclineHelper = new RevenueCost();
    _loadDefaultData();
    open('partials/shipments/modal/add_rc_line.html');
  }
  
  void _loadDefaultData(){
    this.asyncSelected = this.shipment.customer.name;
    this.rclineHelper.billTo = this.shipment.billto;
    this.rclineHelperCustomer = this.shipment.customer;
    this.rclineHelper.currency = this.shipment.customer.currency;
    this.rclineHelper.vendor =  this.shipment.carriers.first.carrier;
    this.rclineHelper.status = 'New'; 
  }

  void saveRCLane(){
    if(this.rclineHelper.is_valid()){
      if(this.rclineHelper.is_new()){
        this.shipment.revCosts.add(this.rclineHelper);        
      }
      modalInstance.close(null);
    }
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

// Begin page 2
  void addNewCarrier(){
    this.shipment.carriers.add(new ShipmentCarrier());
  }

// End page 2

  void _loadCarrierInShipperCarrier( data ,  ShipmentCarrier sc){
    Carrier carrier = new Carrier();
    carrier.loadWithJson(data);
    sc.carrier = carrier;
  }

  void _loadCustomsbroker(data){
    Customer custombroker = new Customer();
    custombroker.loadWithJson(data);
    this.shipment.customBroker = custombroker;
  }

  void _loadBilltoCustomer(data){
    Customer billto = new Customer();
    billto.loadWithJson(data);
    this.billto = billto;
  }

  void _loadbillto(data){
    Location location = new Location();
    location.loadWithJson(data);
    this.shipment.billto = location;
  }
  
  void _loadCustomer(data){
    Customer customer = new Customer();
    customer.loadWithJson(data);
    this.shipment.customer = customer;
  }
  
  void changeRevCost(RevenueCost revcost){
    if(revcost.currency != defaultCurrency){
      revcost.costAmountCa = this._exchange.calculateCosts(revcost.amount);
      revcost.revenueAmountCa = this._exchange.calculateRevenue(revcost.amount);
      revcost.calculateProfit();
      checkTotalRevCosts();
    }
  }
  
  void checkTotalRevCosts(){
     this.shipment.revCosts.forEach((rc){
       helperTotal['amount'] += double.parse(rc.amount);
       helperTotal['amountRevCa'] += double.parse(rc.revenueAmountCa);
       helperTotal['amountCostCa'] += double.parse(rc.costAmountCa);
    });
     helperTotal['profit'] = helperTotal['amountCostCa'] - helperTotal['amountRevCa'];
  }

// to change
  bool internationalShipments() => true;
// 
  
  bool has_shippers() => this.shipment.shippers.isNotEmpty;
  bool maxCarrier() => this.shipment.carriers.length > 1;
  bool otherCustomerInBillTo() => this.billto != null && this.billto.id != this.shipment.customer.id;
  bool inStep(int step) => step == this.step;
  int toStep(int step) => this.step = step;
  bool hasConsigneeLocations() => this.consigne_locations.length > 0;
  bool hasMoreThanOneCarrier() => this.shipment.carriers.length > 1;  
  bool hasMoreOneShipperLocations() => this.shipment.shippers.length > 1;
  bool hasValidShipper() => this.shipment.shippers.length > 1 || this.shipment.consignees.length > 1;
  bool hasValidConsignee() => this.shipment.consignees.length > 1 || this.shipment.consignees.length > 0 && this.shipment.shippers.length > 1;
  bool hasValidShipment() => hasValidShipper() && hasValidConsignee();
  bool _isEditPath() => _routeProvider.routeName == 'shipment_edit';
  bool _isNewPath() => _routeProvider.routeName == 'shipment_new';
  bool _isIndexPath() => _routeProvider.routeName == 'shipment_list';
}
