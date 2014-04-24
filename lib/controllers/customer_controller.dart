part of transnode;

@NgController(
    selector: '[customer-controller]',
    publishAs: 'controller')
class CustomerController {
  @NgTwoWay("customer")
  Customer customer;
  RouteProvider _routeProvider;
  Router _router;

  final CustomerService _customerService;

  CustomerController(this._customerService, this._routeProvider, this._router) {
    this.customer = new Customer();
    if (_is_edit_path()) {
      _customerService.get(_routeProvider.parameters['customerId']).then((_) =>
          this.customer = _);
    } else {
      //other paths...
    }
  }

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

  bool _is_edit_path() => _routeProvider.routeName == 'customer_edit';
  bool _is_new_path() => _routeProvider.routeName == 'customer_edit';
}
