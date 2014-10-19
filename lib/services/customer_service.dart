part of transnode;

@InjectableService()
class CustomerService {
  static String url = '/customers';
  UserService user;
  MessagesService _messageServices;
  ApiService _api;
  Map countriesx;

  CustomerService(this._api, this.user, this._messageServices);

  Future index() {
    return _api.request('get', url);
  }

  Future loadForm() {
    return _api.request("post", url + "/form_step1")
      .then((HttpResponse response) => response.data);
  }
  
  Future loadForm_step2(int customerId) {
    return _api.request("post", url + "/form_step2/"+customerId.toString())
      .then((HttpResponse response) => response.data);
  }
  
  Future load_billToLocations(int customerId){
    String urlService = "/bill_to_location/"+customerId.toString();
    return load_data(urlService);    
  }
  
  Future<List> getLocationByNameAndRole(String role, String vendorName) {
    return _api.request("get", url + "/locations_by_role/${role}/${vendorName.toString()}")
       .then((HttpResponse response){ 
        return response.data['customers'];      
      });
  }

  Future load_data(String stringUrl) {
    return _api.request("post", url + stringUrl)
      .then((HttpResponse response) => response.data);
  }
  
  Future<Location> getLocation(String locationId) {
    return _api.request("get", url + "/location_by_id/${locationId.toString()}" )
      .then((HttpResponse response) => LoadModel.loadLocation(response.data));
  }
  
  Future<Invoice> getInvoice(String billToId) {
    return _api.request("get", url + "/consolidated_invoice/${billToId.toString()}" )
      .then((HttpResponse response) => LoadModel.loadInvoice(response.data));
  }
  
  Future<Customer> get(String customerId) {
    return _api.request("get", url + "/" + customerId.toString())
      .then((HttpResponse response) => _loadCustomer(response.data));
  }

  Future<Customer> delete(String customerId) {
    return _api.request("delete", url + "/" + customerId.toString())
      .then((_) => _messageServices.add("info", "customer delete it"));
  }

  Future save(Customer customer) {
    String method, parameters, path;
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

  

  void _loadFormData(response) {
    countriesx = response['countries'];
  }

  String params_update(Customer customer) {
    return encode({
      "customer": customer.to_map(),
      "id": customer.id
    });
  }
  String params(Customer customer) {
    return encode({
      "customer": customer.to_map()
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
