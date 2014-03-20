library transnode.user_service;

import 'package:transnode/models/customer.dart';

import 'dart:convert';
import 'dart:async';
import 'package:angular/angular.dart';

@NgInjectableService()
class CustomerService{
  static final String api_url = 'http://0.0.0.0:3000';
  static final String customers = api_url + '/customers';

  bool sucessfull = false;
  final Http _http;
  
  CustomerService(this._http);
  
  Future<HttpResponse> save(Customer customer) {
    return _http.post(customers, this.params(customer))
      .then((HttpResponse response) {
        print ("WIIII");
      })
      .catchError((error) {
        throw('Something is bad!');
      });
  }
  
  String params(Customer customer){
    return JSON.encode(customer.to_map());
  }  
}