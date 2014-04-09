part of transnode;

@NgInjectableService()
class CustomerService {
  static final String api_url = 'http://0.0.0.0:3000';
  static final String customers = api_url + '/customers';

  Http _http;
  String error;
  UserService user;

  CustomerService(this._http,this.user) {
    this.error = "";
  }

  Future save(Customer customer) {
    this.error = "";

    return _http.post(customers, this.params(customer))
      .catchError((HttpResponse response) {
        if(response.status == 422) {
          print("Nice, i got the error");
          customer.set_errors(JSON.decode(response.data));
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
