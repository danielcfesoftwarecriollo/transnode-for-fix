part of transnode;

@NgInjectableService()
class CustomerService {
  static String url = '/customers';
  UserService user; 
  MessagesService _messageServices;
  ApiService _api;


  CustomerService(this._api,this.user,this._messageServices) {
  }

  Future index(){
    return _api.request('get', '/customers');
  }
  
  Future save(Customer customer) {
    return _api.request('post', '/customers',data:params(customer))
      .catchError((HttpResponse response) {
        if(response.status == 422) {
          Map<String,List<String>> errors = JSON.decode(response.data);
          _messageServices.add("danger","Review the errors in the form");
          customer.set_errors(errors);
        }
      });
  }

  String params(Customer customer) {
    return JSON.encode({ "customer": customer.to_map() });
  }
}
