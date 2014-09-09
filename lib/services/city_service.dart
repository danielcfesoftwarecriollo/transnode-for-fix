part of transnode;

@InjectableService()
class CityService {
  ApiService _api;
  Router _router;
  UserService _user_service;

  CityService(this._api, this._router, this._user_service);

  Future<HttpResponse> get_cities_by_code(String queryCode) {
    return _api.request("get", "/cities/by_code/" + queryCode.toString())
      .then((HttpResponse response){
        return response.data;
      });
  }
  
  Future<HttpResponse> get_cities_by_name(String queryCode) {
    return _api.request("get", "/cities/by_name/" + queryCode.toString())
      .then((HttpResponse response){
        return response.data;
      });
  }
}
