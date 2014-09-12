part of transnode;

@InjectableService()
class CityService {
  ApiService _api;
  Router _router;
  UserService _user_service;
  String url= "/cities";

  CityService(this._api, this._router, this._user_service);
  
  City _loadCity(map) {
    City c = new City();
    c.loadWithJson(map);
    return c;
  }
  
  Future<City> get(String cityId) {
    return _api.request("get", url + "/" + cityId.toString())
      .then((HttpResponse response) => _loadCity(response.data));
  }
  
  Future<HttpResponse> get_cities_by_code(String queryCode) {
    return _api.request("get", url + "/by_code/" + queryCode.toString())
      .then((HttpResponse response){
        return response.data;
      });
  }
  
  Future<HttpResponse> get_cities_by_name(String queryCode) {
    return _api.request("get", url + "/by_name/" + queryCode.toString())
      .then((HttpResponse response){
        return response.data;
      });
  }
  
}
