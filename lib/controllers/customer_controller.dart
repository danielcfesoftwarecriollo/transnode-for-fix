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

  CustomerController(this._customerService, this._routeProvider, this._router) {
    this.customer = new Customer();
    if (_isEditPath()) {
      _customerService.get(_routeProvider.parameters['customerId']).then((_) =>
          this.customer = _);
    } else if (_isIndexPath()) {
      this.customers = [];
      this._load_customers();
    }
  }

  bool get has_customers => this.customers.isNotEmpty;
  
  void add_location() {
    this.customer.new_empty_location();
  }

  void delete_location(Location location) {
    this.customer.delete_location(location);
  }
  void add_contact() {
    this.customer.new_empty_contact();
  }

  void delete_contact(Contact contact) {
    this.customer.delete_contact(contact);
  }

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
  
  void _add_customer(Map<String, dynamic> json) {
    Customer customer = new Customer();
    customer.loadWithJson(json);
    this.customers.add(customer);
  }

  bool _isEditPath() => _routeProvider.routeName == 'customer_edit';
  bool _isNewPath() => _routeProvider.routeName == 'customer_new';
  bool _isIndexPath() => _routeProvider.routeName == 'customers';
}
