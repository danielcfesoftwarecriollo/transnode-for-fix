part of transnode;

@InjectableService()
class LocationService {
  ApiService _api;
  Router _router;
  UserService _user_service;
  MessagesService _messageServices;

  LocationService(this._messageServices, this._api, this._router, this._user_service);

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

  Future<List<City>> getCitiesByState(id) { 
    return _api.request("get", "/locations/cities_by_state/${id}")
      .then((HttpResponse response){
        List aux = [];
        response.data['cities'].forEach((map_city){
          aux.add(LoadModel.loadCity(map_city));
        });
        return aux;
      });
  }
  
  Future<HttpResponse> update_location(location) { 
    return _api.request("put", "/locations",params:{})
      .then((HttpResponse response){
        print(response);
      });
  }
  
}
