library transnode.api_service;

import 'package:angular/angular.dart';
import 'package:transnode/services/user_service.dart';

import 'dart:async';
import 'dart:convert';

@NgInjectableService()
class ApiService {
  static final String api_url = 'http://localhost:3000';
  final Http _http;

  User user;

  ApiService(this._http, this.user);

  String token() {
    return user.token;
  }
  void setToken(String token) {
    _http.defaults.headers.setToken(token);
  }
  void cleanToken() {
    _http.defaults.headers.cleanToken();
  }

  bool isAuthenticated() {
    return user.isAuthenticated();
  }

  Map<String, String> http_headers() {
    return {
      'Authorization': "Token token=${token()}"
    };
  }

  Future<HttpResponse> connection(String method, String route, [Map params]) {
    method = method.toUpperCase();
    if (params == null) {
      params = {};
    }
    String string_params = JSON.encode(params);
    Future http_response = this._call_by_method(method, route, string_params);
    http_response.catchError((HttpResponse response) {
      if (_error_in_server(response.status)) {

      } else if (_session_out(response.status)) {

      } else if (_forbidden_access(response.status)) {

      }
    });
    return null;
  }

  Future<HttpResponse> _call_by_method(String method, String route, String
      params) {
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

  Future _post(route, params) => _http.post(route, params);

  Future _get(route, params) => _http.get(route, params: params);

  Future _put(route, params) => _http.put(route, params);

  Future _delete(route, params) => _http.delete(route, params: params);

  bool _error_in_server(int status) => [500, 404].contains(status);

  bool _session_out(int status) => status == 401;

  bool _forbidden_access(int status) => status == 403;
}
