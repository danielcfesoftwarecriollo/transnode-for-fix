library transnode.customer_controller;
import 'package:angular/angular.dart';
import 'package:transnode/models/customer.dart' show Customer;
import 'package:transnode/models/customer_saver.dart' show CustomerSaver;


@NgController(
    selector: '[customer-controller]',
    publishAs: 'controller')
    
class CustomerController {
  Customer customer;

  CustomerController(){
    this.customer = new Customer();
  }
  void create(){
    CustomerSaver customer_saver = new CustomerSaver(this.customer);
    customer_saver.save();
    if(customer_saver.sucessfull)
      print("WE ARE THE CHAMPIONS");
    else
      print("for the next time");
  }
  void reset(){

  }
}
