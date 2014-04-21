part of transnode;

@NgController(
    selector: '[customer-controller]',
    publishAs: 'controller')
class CustomerController {
  @NgTwoWay("customer")
  Customer customer;
  final CustomerService customer_service;

  CustomerController(this.customer_service) {
    this.customer = new Customer();
  }

  void add_location() {
    this.customer.new_empty_location();
  }

  void delete_location(Location location){
    this.customer.delete_location(location);
  }

  void create() {
    if(this.customer.full_valid()){
      var response = this.customer_service.save(this.customer);    
      response.then((HttpResponse response) {
        if(response == null)
          return false;
      });      
    }

  }
}
