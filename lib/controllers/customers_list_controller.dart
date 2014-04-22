part of transnode;

@NgController(
    selector: '[customer-list-controller]',
    publishAs: 'ctrl')
class CustomersListController {
  @NgTwoWay("customers")
  List<Customer> customers;
  final CustomerService customer_service;

  CustomersListController(this.customer_service) {
    this.customers = [];
    this.load_customers();
  }

  bool get has_customers => customers.isNotEmpty;
  
  void load_customers() {
    var response = this.customer_service.index();
    response.then((HttpResponse response) {
      
      response.data.forEach(_add_customer);
      if (response == null) return false;
    });
  }
  void todo(){
    window.alert("TODO");
  }
  
  void _add_customer(Map<String,dynamic> json){
    Customer customer = new Customer();
    customer.loadWithJson(json);
    this.customers.add(customer); 
  }
}
