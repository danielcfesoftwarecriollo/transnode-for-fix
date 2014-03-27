library transnode.session_service;

import 'package:angular/angular.dart';
import 'package:transnode/services/api_service.dart';

import 'dart:async';

@NgInjectableService()
class SessionService {
  ApiService _api;
  SessionService(this._api);
  
  Future signIn(String email, String password) {
    Map data = _create_params(email,password);
    return _api.connection("post", "/sessions", data).then((HttpResponse response){
      _api.setDataUser(email, response.data['token']);
    });
  }
  
  Future signOut() {
    return _api.connection("delete", "/sessions").then((HttpResponse response) {
      _api.cleanToken();
    }).catchError((error) {
      print('oops');
    });
  }
  
  Map _create_params(String email, String password){
    return {
      'user': {
        'email': email,
        'password': password
      }
    };
  }
}