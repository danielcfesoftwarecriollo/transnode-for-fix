part of transnode;

@InjectableService()
class CarrierService {
  static String url = '/carriers';
  UserService user;
  MessagesService _messageServices;
  ApiService _api;
  Map countries;

  CarrierService(this._api, this.user, this._messageServices);

  Future index() {
    return _api.request('get', url);
  }

  Future loadForm() {
    return _api.request("post", url + "/form")
      .then((HttpResponse response) => response.data);
  }
  
  Future load_data(String stringUrl) {
    return _api.request("post", url + stringUrl)
      .then((HttpResponse response) => response.data);
  }
  
  Future<Carrier> get(String carrierId) {
    return _api.request("get", url + "/" + carrierId.toString())
      .then((HttpResponse response) => _loadCarrier(response.data));
  }

  Future<List> getCarriersByName(String carrierString) {
    return _api.request("get", url + "/carriers_by_name/" + carrierString.toString())
       .then((HttpResponse response){ 
        return response.data['carriers'];      
      });
  }
  
  Future<List> getVendorsByName(String vendorName) {
    return _api.request("get", url + "/vendors_by_name/" + vendorName.toString())
       .then((HttpResponse response){ 
        return response.data['carriers'];      
      });
  }

  Future<Carrier> delete(String carrierId) {
    return _api.request("delete", url + "/" + carrierId.toString())
      .then((_) => _messageServices.add("info", "carrier delete it"));
  }

  Future save(Carrier carrier) {
    String method, parameters, path;
    if (carrier.is_new()) {
      method = 'post';
      parameters = params(carrier);
      path = url;
    } else {
      method = 'put';
      parameters = params_update(carrier);
      path = url + "/" + carrier.id.toString() ; 
    }
    
    return _api.request(method, path, data: parameters)
      .catchError((HttpResponse response) {
        if (response.status == 422) {
          Map<String, List<String>> errors = JSON.decode(response.data);
          _messageServices.add("danger", "Review the errors in the form");
          carrier.set_errors(errors);
        }
      });
  }

  Carrier _loadCarrier(map) {
    Carrier carrier = new Carrier();
    carrier.loadWithJson(map);
    return carrier;
  }

  List<Carrier> _loadCarriers(map) {
    List<Carrier> carriers = [];
    map.forEach((map_carrier){
      carriers.add(_loadCarrier(map_carrier));
    });
    return carriers;
  }

  void _loadFormData(response) {
    countries = response['countries'];
  }

  String params_update(Carrier carrier) {
    return encode({
      "carrier": carrier.to_map(),
      "id": carrier.id
    });
  }
  String params(Carrier carrier) {
    return encode({
      "carrier": carrier.to_map()
    });
  }
  String params_id(Carrier carrier) {
    return encode({
      "id": carrier.id
    });
  }

  String encode(Map map) {
    return JSON.encode(map);
  }
  
  Future<List> getCarriersLanePrice(String queryString) {
    return _api.request("get", url + "/prices_by_filters/" + queryString.toString())
       .then((HttpResponse response){ 
        return response.data;
      });
  }
}
