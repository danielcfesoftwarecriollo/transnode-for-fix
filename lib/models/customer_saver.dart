import 'package:transnode/models/customer.dart' show Customer;
import 'dart:html';

class CustomerSaver{
  Customer customer;
  
  CustomerSaver(this.customer);
  
  void save() {
    HttpRequest request = new HttpRequest();
    request.onReadyStateChange.listen((_) {
    if (request.readyState == HttpRequest.DONE &&
      (request.status == 200 || request.status == 0)) {
        print(request.responseText);
      }
    });
    request.open("POST", "/customers", async: false);
    request.send(this.to_s());
  }
  
  String to_s(){
    return "code="+customer.code+"&name="+customer.name+"&city="+customer.city+
        "&state="+customer.state+"&zip="+customer.zip;        
  }
}