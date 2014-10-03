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
    return _api.request('get', url)
        .then((HttpResponse response) => response.data);
  }

  Future customerByName( val ) {
    return _api.request("post", url + "/customers/"+val)
      .then((HttpResponse response) =>  response.data['customers']);
  }
  
  Future loadForm() {
    return _api.request("post", url + "/form")
      .then((HttpResponse response) => response.data);
  }

  Future load_shipments(String query_str){
    String urlService = "/shipments/"+query_str;
    return load_data(urlService);    
  }

  Future load_shipment(String query_str){
    String urlService = "/shipment_by_id/"+query_str;
    return load_data(urlService);    
  }

  Future load_data(String stringUrl) {
    return _api.request("post", url + stringUrl)
      .then((HttpResponse response){
      return response.data;
    });
  }

  Future load_consigneLocations(int shipmentId){
    String urlService = "/consignee_locations/"+shipmentId.toString();
    return load_data(urlService);    
  }
  
  Future load_billToLocations(int shipmentId){
    String urlService = "/billto_location/"+shipmentId.toString();
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

  Future load_customer(String query_str){
    String urlService = "/customer_by_id/"+query_str;
    return load_data(urlService);    
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
