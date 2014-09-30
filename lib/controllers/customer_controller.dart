part of transnode;

@Controller(selector: '[customer-controller]', publishAs: 'ctrl')
class CustomerController {
  @NgTwoWay("customer")
  Customer customer;
  @NgTwoWay("customers")
  List<Customer> customers;
  RouteProvider _routeProvider;
  Router _router;
  final CustomerService _customerService;
  
  // helpers
  List countries;
  var statesOfCountries;
  int  step;
  Map  billTo;
  List billTos;
  List customBrokers;
  List importBrokers;
  List exportBrokers;
  List currencyRiskFactors;
  List salesRepIds;
  List territoryIds;
  List locations;
  List sources;
  List cities;
  int billToId;
  
  CustomerController(this._customerService, this._routeProvider, this._router) {
    this.customer = new Customer();
    this.cities = [];
    this.billTos = [];
    if (_isEditPath()) {
      var customer_id = _routeProvider.parameters['customerId'];
      _customerService.get(customer_id).then((_) => this.customer = _);
      load_form();
    } else if (_isShowPath()) {
      var customer_id = _routeProvider.parameters['customerId'];
      _customerService.get(customer_id).then((_) => this.customer = _);
      load_form();
    } else if (_isIndexPath()) {
      this.customers = [];
      this._load_customers();
    } else if(_isNewPath()){
      load_form();
    }
    this.step = 1;
  }

  void load_form(){
    _customerService.loadForm().then((response){
      this.countries = response['countries'];
      this.statesOfCountries = response['states_of_countries'];
      load_cities(response['cities']);
    });
    
    new Timer(const Duration(milliseconds: 1000), () {
      List countries = querySelectorAll('.countries');
      countries.forEach((element) => dispachChange(element));
    });
  }
  
  void load_cities(List cities ){
    cities.forEach(( city_attr ){
      City new_city = new City();
      new_city.loadWithJson(city_attr);
      
      this.cities.add(new_city);
    });
  }
  
  int stepForm(int step) => this.step = step;
  
  void dispachChange(SelectElement element){
    Event changeE = new Event('change');
    element.dispatchEvent(changeE);
  }

  bool get has_customers => this.customers.isNotEmpty;

  void add_location() {
    this.customer.new_empty_location();
  }

  void delete(Customer customer) {
    if (window.confirm("Are you sure to delete this item?")) {
      _customerService.delete(customer.id.toString()).then((_){
        customers.remove(customer);
      });
    } else {
      print("false ");
    }
  }
  void delete_location(Location location) {
    this.customer.delete_location(location);
  }
  
  Customer _loadCustomer(map) {
    Customer customer = new Customer();
    customer.loadWithJson(map);
    return customer;
  }
  
  has_many_locations(){
    customer.has_many_locations();
  }
  
//  void add_contact() {
//    this.customer.new_empty_contact();
//  }
//
//  void delete_contact(Contact contact) {
//    this.customer.delete_contact(contact);
//  }

  void save() {
    if(this.step == 1){
      save_step1();
    }else if(this.step == 2){
      save_step2();
    }
  }
  
  void save_step1(){
    if (this.customer.valid_step1()) {
      var responseSave = this._customerService.save(this.customer);
      responseSave.then((HttpResponse response) {
        update_customer(response);
        var responseLoadFormStep2 = this._customerService.loadForm_step2(this.customer.id);
        this.stepForm(2);
        responseLoadFormStep2.then((response2) {
          print(response2);
          _loadForm_step2(response2);
        });
      });
    }
  }
  
  void update_customer( response ){
    if(response.data.length > 0){
      Customer c = _loadCustomer(response.data);
      this.customer = c;
    }
  }
  
  void save_step2(){
    if (this.customer.valid_step2()) {
      var response = this._customerService.save(this.customer);
      response.then((HttpResponse response) {
        if (response == null) return false;
        _router.go('customers', {});
      });
    }
  }

  void _load_customers() {
    var response = this._customerService.index();
    response.then((HttpResponse response) {
      response.data.forEach(_add_customer);
      if (response == null) return false;
    });
  }
  
  void _loadForm_step2(Map formData) {
    this.billTo = formData['bill_to'];
    this.billTos = formData['bill_tos'];
    this.locations = formData['locations'];
    this.billToId = formData['customer_bill_to_id'];
    this.customBrokers = formData['custom_brokers'];
    this.importBrokers = formData['import_brokers'];
    this.exportBrokers = formData['export_brokers'];
    this.currencyRiskFactors = formData['currency_risk_factors'];
    this.salesRepIds = formData['sales_rep_ids'];
    this.territoryIds = formData['territory_ids'];
    this.sources = formData['sources'];
  }

  void changeCountries (currentLocation) {
     new Timer(const Duration(milliseconds: 1), () {
       print(currentLocation.countryId);
       List x = this.getStatesByCountry(currentLocation.countryId.toString());
       currentLocation.states = x;
       print(currentLocation.states);
     });
  }

  List getStatesByCountry(String countryId) {
    if(countryId.toString() != 'null'){
      return this.statesOfCountries[countryId]['states'];
    }else{
      return [];
    }
  }

  void change_bill_to() {
    print(this.customer.billToId);
    var response = this._customerService.load_billToLocations(this.customer.id);
    this.stepForm(2);
    response.then((response) {
      print(response);
      this.locations = response['locations'];
      this.billTo = response['bill_to'];
    });
  }
  
  void _add_customer(Map<String, dynamic> json) {
    Customer customer = new Customer();
    customer.loadWithJson(json);
    this.customers.add(customer);
  }

  void to_index(){
    _router.go('carriers', {});
  }

  bool _isEditPath() => _routeProvider.routeName == 'customer_edit';
  bool _isShowPath() => _routeProvider.routeName == 'customer_show';
  bool _isNewPath() => _routeProvider.routeName == 'customer_new';
  bool _isIndexPath() => _routeProvider.routeName == 'customers';
}
