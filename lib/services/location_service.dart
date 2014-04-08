library transnode.session_service;

import 'package:angular/angular.dart';
import 'package:transnode/services/api_service.dart';
import 'package:transnode/services/user_service.dart';

import 'dart:async';
import 'dart:convert';

@NgInjectableService()
class LocationService {
  ApiService _api;
  Router _router;
  UserService _user_service;

  LocationService(this._api, this._router, this._user_service);

  Future all_index() {
    return _api.request("get", "/locations")
      .then((HttpResponse response){
        print(response);
      });
  }
  
}
