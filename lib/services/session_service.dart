library transnode.session_service;

import 'package:angular/angular.dart';
import 'package:transnode/services/api_service.dart';
import 'package:transnode/services/user_service.dart';

import 'dart:async';
import 'dart:convert';

@NgInjectableService()
class SessionService {
  ApiService _api;
  Router _router;
  UserService _user_service;

  SessionService(this._api, this._router, this._user_service);

  Future signIn(String email, String password) {
    return _api.request("post", "/sessions", data: _serialize(email, password))
      .then((HttpResponse response){
        _user_service.email = email.trim();
        _user_service.token = response.data['token'];
        _router.go('home',{});
      });
  }

  Future signOut() {
    return _api.request("delete", "/sessions").then((HttpResponse response) {
      _user_service.cleanToken();
      _router.go("login", {});
    });
  }

  String _serialize(String email, String password) {
    return JSON.encode({
      'user': {
        'email': email,
        'password': password
      }
    });
  }
}
