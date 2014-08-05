part of transnode;

@InjectableService()
class LocationService {
  ApiService _api;
  Router _router;
  UserService _user_service;

  LocationService(this._api, this._router, this._user_service);

  Future<HttpResponse> all_index() {
    return _api.request("get", "/locations")
      .then((HttpResponse response){
        print(response);
      });
  }
  Future<HttpResponse> location(id) { 
    return _api.request("get", "/locations/"+id)
      .then((HttpResponse response){
        print(response);
      });
  }
  
  Future<HttpResponse> update_location(location) { 
    return _api.request("put", "/locations",params:{})
      .then((HttpResponse response){
        print(response);
      });
  }
  
}
