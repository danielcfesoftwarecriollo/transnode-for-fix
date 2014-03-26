library transnode.customer_controller;

import 'package:angular/angular.dart';
import 'package:transnode/models/customer.dart';
import 'package:transnode/services/customer_service.dart';

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

  void add_contact() {
    this.customer.new_empty_contact();
  }

  void create() {
    var response = this.customer_service.save(this.customer);

    response.then((HttpResponse response) {
      if(response == null)
        return false;
    });
  }
}
