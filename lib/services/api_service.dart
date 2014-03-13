library transnode.api_service;

import 'package:angular/angular.dart';
import 'package:transnode/services/user_service.dart';

import 'dart:convert';
import 'dart:async';
import 'dart:html';

@NgInjectableService()
class ApiService {
  static final String api_url = '';
  static final String signin_url = api_url + '/sessions';
  static final String signout_url = api_url + '/sessions';
  User user;

  final Http _http;

  ApiService(this._http, this.user);

  String token() {
    return user.token;
  }

  bool isAuthenticated() {
    return user.isAuthenticated();
  }
  
  Map<String, String> http_headers() {
    return {'Authorization':"Token token=${token()}"};
  }
  
  Future signIn(String email, String password) {
    var data = {
      'user': {
        'email':    email,
        'password': password
      }
    };

    return _http.post(signin_url, JSON.encode(data))
      .then((HttpResponse response) {
        user.token = response.data['token'];
        user.email = email;
      })
      .catchError((error) {
        throw('not this time');
      });
  }

  Future signOut() {        
    return _http.delete(signout_url, headers: http_headers())
      .then((HttpResponse response) {
        user.token = null;
      })
      .catchError((error) {
        print('oops');
      });
  }
}