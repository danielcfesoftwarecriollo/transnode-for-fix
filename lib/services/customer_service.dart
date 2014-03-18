library transnode.user_service;

import 'package:transnode/models/customer.dart';
import 'package:transnode/models/saver.dart';
import 'dart:html';

class CustomerService extends Saver{
  bool sucessfull = false;
    
  bool save(customer) {
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
    request.send(this.params(customer));
    return this.sucessfull;
  }
  
  String params(Customer customer){
    return this.map_to_param(customer.to_map());
  }
 
}