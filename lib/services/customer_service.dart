part of transnode;

@NgInjectableService()
class CustomerService {
  static final String api_url = 'http://0.0.0.0:3000';
  static final String customers = api_url + '/customers';

  Http _http;
  String error;
  UserService user;
  MessagesService _messageServices;

  CustomerService(this._http,this.user,this._messageServices) {
    this.error = "";
  }

  Future index(){
    return _http.get(customers);
  }
  
  Future save(Customer customer) {
    this.error = "";

    return _http.post(customers, this.params(customer))
      .catchError((HttpResponse response) {
        if(response.status == 422) {
          Map<String,List<String>> errors = JSON.decode(response.data);
          _messageServices.add("Review the errors in the form");
          print(errors);
          customer.set_errors(errors);
        }
        else {
          this.error = "the server is down";
        }
      });
  }

  bool has_errors() {
    return this.error != "";
  }

  String params(Customer customer) {
    return JSON.encode({ "customer": customer.to_map() });
  }
}
