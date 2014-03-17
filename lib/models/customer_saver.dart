import 'package:transnode/models/customer.dart' show Customer;
import 'dart:html';

class CustomerSaver{
  Customer customer;
  bool sucessfull = false;
  
  CustomerSaver(this.customer);
  
  void save() {
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
    request.send(this.to_s());
  }
  
  String to_s(){
    return this.customer.to_map().toString();
  }
  
  bool sucessful(request){
    return request.readyState == HttpRequest.DONE && (request.status == 200 || request.status == 0);
  }
  
  String map_to_param(Map map){
    Set<String> params = new Set();
    map.forEach((k,v) => v != null ? params.add(k+'='+v): "" );
    return params.join("&");
  }
}