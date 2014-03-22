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
  bool error;
  String full_messages;
  CustomerController(this.customer_service){
    this.customer = new Customer();
    this.error = false;
    this.full_messages = "";
  }
  void add_contact(){
    print("adding contact");
    this.customer.new_empty_contact();
  }
  void create(){
    this.customer_service.save(this.customer);
    if(this.customer_service.sucessfull){
      print("we are the champions");
    }
    else{
      this.error = true;
      this.full_messages = "We have errors... how knows...";
    }
  }
}
