part of transnode;

@NgController(selector: '[customer-controller]', publishAs: 'ctrl')
class CustomerController {
  @NgTwoWay("customer")
  Customer customer;
  @NgTwoWay("customers")
  List<Customer> customers;
  RouteProvider _routeProvider;
  Router _router;
  final CustomerService _customerService;
  List countries;
  var statesOfCountries;

  CustomerController(this._customerService, this._routeProvider, this._router) {
    this.customer = new Customer();
    _customerService.loadForm().then((response){
      this.countries = response['countries'];
      this.statesOfCountries = response['states_of_countries'];
    });
    if (_isEditPath()) {
      var customer_id = _routeProvider.parameters['customerId'];
      _customerService.get(customer_id).then((_) => this.customer = _);
      
    } else if (_isShowPath()) {
      var customer_id = _routeProvider.parameters['customerId'];
      _customerService.get(customer_id).then((_) => this.customer = _);      
    } else if (_isIndexPath()) {
      this.customers = [];
      this._load_customers();
    }
//    this.loadStates();
    
    new Timer(const Duration(milliseconds: 1000), () {
      List countries = querySelectorAll('.countries') ;
      countries.forEach((element) => dispachChange(element));
    });
//     
//   window.onContentLoaded.listen((e){
//
//   });
  }
//  void loadStates(){
//    this.customer.locations.forEach((location){
//      if(location.countryId != null){
//        location.states = this.getStatesByCountry(location.countryId.toString()); 
//      }
//    });
//  }
  
  
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
  
//  void add_contact() {
//    this.customer.new_empty_contact();
//  }
//
//  void delete_contact(Contact contact) {
//    this.customer.delete_contact(contact);
//  }

  void save() {
    if (this.customer.full_valid()) {
      var response = this._customerService.save(this.customer);
      response.then((HttpResponse response) {
        if (response == null) return false;
        _router.go('customers', {});
      });
    }
  }

  void todo() {
    window.alert("TODO");
  }

  void _load_customers() {
    var response = this._customerService.index();
    response.then((HttpResponse response) {
      response.data.forEach(_add_customer);
      if (response == null) return false;
    });
  }
  
  void _load_form_customers() {
    var response = this._customerService.index();
    response.then((HttpResponse response) {

      response.data.forEach(_add_customer);
      if (response == null) return false;
    });
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
    return this.statesOfCountries[countryId]['states'];
  }

  void _add_customer(Map<String, dynamic> json) {
    Customer customer = new Customer();
    customer.loadWithJson(json);
    this.customers.add(customer);
  }

  bool _isEditPath() => _routeProvider.routeName == 'customer_edit';
  bool _isShowPath() => _routeProvider.routeName == 'customer_show';
  bool _isNewPath() => _routeProvider.routeName == 'customer_new';
  bool _isIndexPath() => _routeProvider.routeName == 'customers';
}
