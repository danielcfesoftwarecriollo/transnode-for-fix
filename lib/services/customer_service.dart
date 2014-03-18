import 'package:transnode/models/customer.dart' show Customer;
import 'package:transnode/models/saver.dart';
import 'dart:html';

class CustomerSaver extends Saver{
  Customer customer;
  bool sucessfull = false;
  
  CustomerSaver(this.customer);
  
  bool save() {
    HttpRequest request = new HttpRequest();
    request.onReadyStateChange.listen((_) {
    if ( this.sucessful(request)) {
      // SUCCESS
        sucessfull = true;
      }
    else{
      // FAIL
      sucessfull = false;
    }
    });
    request.open("POST", "/customers", async: false);
    request.send(this.params());
    return this.sucessfull;
  }
  
  String params(){
    return this.map_to_param(this.customer.to_map());
  }
 
}