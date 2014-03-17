library transnode.customer_controller;
import 'package:angular/angular.dart';
import 'package:transnode/models/customer.dart' show Customer;
import 'package:transnode/models/customer_saver.dart' show CustomerSaver;


@NgController(
    selector: '[customer-controller]',
    publishAs: 'controller')
    
class CustomerController {
  Customer customer;
  bool error;
  String full_messages;
  CustomerController(){
    this.error = false;
    this.customer = new Customer();
    this.full_messages = "";
  }
  void create(){
    CustomerSaver customer_saver = new CustomerSaver(this.customer);
    customer_saver.save();
    if(customer_saver.sucessfull){
      print("we are the champions");
    }
    else{
      this.error = true;
      this.full_messages = "We have errors... how knows...";
    }
  }
}
