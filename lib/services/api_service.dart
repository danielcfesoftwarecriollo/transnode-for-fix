library transnode.api_service;

import 'package:angular/angular.dart';
import 'package:transnode/services/user_service.dart';

import 'dart:convert';
import 'dart:async';

@NgInjectableService()
class ApiService {
  static final String api_url = 'http://localhost:3000';
  static final String signin_url = api_url + '/sessions';
  static final String signout_url = api_url + '/sessions';
  final Http _http;

  User user;

  ApiService(this._http, this.user);

  String token() {
    return user.token;
  }
  void setToken(){
    _http.defaults.headers.setToken();
  }
  void cleanToken(){
    _http.defaults.headers.cleanToken();
  }

  bool isAuthenticated() {
    return user.isAuthenticated();
  }

  Map<String, String> http_headers() {
    return {'Authorization':"Token token=${token()}"};
  }
  
  Future connection(String method,String route, Map params){
    method = method.toUpperCase();
    Future http_response = this._call_by_method(method,route,params);
    http_response.catchError((HttpResponse response) {
      // HAndle error
    });
    return null;
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
        
      })
      .catchError((error) {
        throw('not this time');
      });
  }

  Future signOut() {
    return _http.delete(signout_url)
      .then((HttpResponse response) {
        user.token = null;
      })
      .catchError((error) {
        print('oops');
      });
  }
  Future _call_by_method(method, route, params){
    Future http_request;
    switch (method) {
      case 'GET':
        http_request = this._get(route, params);
        break;
      case 'POST':
        http_request = this._post(route, params);
        break;
      case 'PUT':
        http_request = this._put(route, params);
        break;
      case 'DELETE':
        http_request = this._delete(route, params);
        break;
      default:
        throw new StateError('Method not valid');
    }
    return http_request;
  }
  
  Future _post(route,params) => _http.post(route,params);

  Future _get(route,params) => _http.get(route,params:params);

  Future _put(route,params) => _http.put(route,params);

  Future _delete(route,params) => _http.delete(route,params:params);

}
