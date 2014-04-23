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
    return _api.request('get', url);
  }
  
  Future<User> get(String userId) {
    return _api.request("get", url + "/" + userId.toString())
     .then((HttpResponse response) => _loadCustomer(response.data));
  }
  
  Future save(Customer customer) {
    return _api.request('post', url ,data:params(customer))
      .catchError((HttpResponse response) {
        if(response.status == 422) {
          Map<String,List<String>> errors = JSON.decode(response.data);
          _messageServices.add("danger","Review the errors in the form");
          customer.set_errors(errors);
        }
      });
  }

  Customer _loadCustomer(map){
    Customer customer = new Customer();
    customer.loadWithJson(map);
    return customer;
  }
  String params(Customer customer) {
    return JSON.encode({ "customer": customer.to_map() });
  }
  String params_id(Customer customer){
    return JSON.encode({ "id": customer.id});    
  }
}
