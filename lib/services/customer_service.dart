part of transnode;

@NgInjectableService()
class CustomerService {
  static String url = '/contacts';
  UserService user;
  MessagesService _messageServices;
  ApiService _api;

  CustomerService(this._api, this.user, this._messageServices);

  Future index() {
    return _api.request('get', url);
  }

  Future<User> get(String userId) {
    return _api.request("get", url + "/" + userId.toString())
      .then((HttpResponse response) => _loadContact(response.data));
  }

  Future save(Customer customer) {
    String method;
    String parameters;
    String path;
    if (customer.is_new()) {
      method = 'post';
      parameters = params(customer);
      path = url;
    } else {
      method = 'put';
      parameters = params_update(customer);
      path = url + "/" + customer.id.toString() ; 
    }
    return _api.request(method, path, data: parameters)
      .catchError((HttpResponse response) {
        if (response.status == 422) {
          Map<String, List<String>> errors = JSON.decode(response.data);
          _messageServices.add("danger", "Review the errors in the form");
          customer.set_errors(errors);
        }
      });
  }

  Customer _loadCustomer(map) {
    Customer customer = new Customer();
    customer.loadWithJson(map);
    return customer;
  }

  String params_update(Customer customer) {
    return encode({
      "customer": customer.to_map_single(),
      "id": customer.id
    });
  }
  String params(Customer customer) {
    return encode({
      "customer": customer.to_map_single()
    });
  }
  String params_id(Customer customer) {
    return encode({
      "id": customer.id
    });
  }

  String encode(Map map) {
    return JSON.encode(map);
  }
}
