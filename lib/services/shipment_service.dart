part of transnode;

@InjectableService()
class ShipmentService {
  static String url = '/shipments';
  UserService user;
  MessagesService _messageServices;
  ApiService _api;
  Map countries;

  ShipmentService(this._api, this.user, this._messageServices);

  Future index() {
    return _api.request('get', url);
  }

  Future loadForm() {
    return _api.request("post", url + "/form")
      .then((HttpResponse response) => response.data);
  }

  Future load_customers(String query_str){
    String urlService = "/customers/"+query_str;
    return load_data(urlService);    
  }

  Future load_customer(String query_str){
    String urlService = "/customer_by_id/"+query_str;
    return load_data(urlService);    
  }

  Future load_data(String stringUrl) {
    return _api.request("post", url + stringUrl)
      .then((HttpResponse response){
      return response.data;
    });
  }

  Future load_consigneLocations(int customerId){
    String urlService = "/consignee_locations/"+customerId.toString();
    return load_data(urlService);    
  }
  
  Future load_billToLocations(int customerId){
    String urlService = "/billto_location/"+customerId.toString();
    return load_data(urlService);    
  }

  Future load_location(int locationId){
    String urlService = "/location/"+locationId.toString();
    return load_data(urlService);    
  }

  Future<Shipment> get(String shipmentId) {
    return _api.request("get", url + "/" + shipmentId.toString())
      .then((HttpResponse response) => _loadShipment(response.data));
  }

  Future<Shipment> delete(String shipmentId) {
    return _api.request("delete", url + "/" + shipmentId.toString())
      .then((_) => _messageServices.add("info", "shipment delete it"));
  }

  Future save(Shipment shipment) {
    String method, parameters, path;
    if (shipment.is_new()) {
      method = 'post';
      parameters = params(shipment);
      path = url;
    } else {
      method = 'put';
      parameters = params_update(shipment);
      path = url + "/" + shipment.id.toString() ; 
    }
    
    return _api.request(method, path, data: parameters)
      .catchError((HttpResponse response) {
        if (response.status == 422) {
          Map<String, List<String>> errors = JSON.decode(response.data);
          _messageServices.add("danger", "Review the errors in the form");
          shipment.set_errors(errors);
        }
      });
  }

  Shipment _loadShipment(map) {
    Shipment shipment = new Shipment();
    shipment.loadWithJson(map);
    return shipment;
  }

  void _loadFormData(response) {
    countries = response['countries'];
  }

  String params_update(Shipment shipment) {
    return encode({
      "shipment": shipment.to_map(),
      "id": shipment.id
    });
  }
  String params(Shipment shipment) {
    return encode({
      "shipment": shipment.to_map()
    });
  }
  String params_id(Shipment shipment) {
    return encode({
      "id": shipment.id
    });
  }

  String encode(Map map) {
    return JSON.encode(map);
  }
}
