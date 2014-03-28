library transnode.api_service;

import 'package:angular/angular.dart';
import 'package:transnode/services/user_service.dart';
import 'package:transnode/services/message_service.dart';

import 'dart:async';
import 'dart:convert';
import 'dart:html';

@NgInjectableService()
class ApiService {
  static String api_url = 'http://localhost:3000';
  final Http _http;

  User user;
  MessageService message;

  ApiService(this._http, this.user, this.message) {
    if (is_production()) {
      api_url = production_path();
    } else {
      api_url = development_path();
    }
  }

  bool is_production() {
    return window.location.hostname != '127.0.0.1';
  }

  String development_path() {
    return "http://0.0.0.0:3000";
  }
  String production_path() {
    return "http://0.0.0.0:3000";
  }

  String token() {
    return user.token;
  }
  void setDataUser(email, token) {
    user.email = email;
    user.token = token;
    setToken();
  }
  void setToken() {
    _http.defaults.headers.setToken(user);
  }
  void cleanToken() {
    user.token = "";
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
    message.cleanMessage();
    method = method.toUpperCase();
    var dinamic_prams = _paramsByMethod(method, params);
    Future http_response = this._callByMethod(method, fullPath(route),
        dinamic_prams);
    http_response.catchError((HttpResponse response) {
      if (_errorInServer(response.status)) {
        message.setError(response);
      } else if (_sessionOut(response.status)) {
        message.setSessionOut(response);
      } else if (_forbiddenAccess(response.status)) {
        message.setForbiddenAccesss(response);
      } else if (_conectionRefuse(response.status)) {
        message.setConectionRefuse(response);
      }
    });
    return http_response;
  }

  String fullPath(path) {
    return api_url + path;
  }
  _paramsByMethod(String method, Map params) {
    switch (method) {
      case "POST":
        return JSON.encode(params);
      default:
        return params;
    }
  }
  Future<HttpResponse> _callByMethod(String method, String route, String
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

  bool _errorInServer(int status) => [500, 404].contains(status);

  bool _sessionOut(int status) => status == 401;

  bool _forbiddenAccess(int status) => status == 403;

  bool _conectionRefuse(int status) => status == 0;

}
