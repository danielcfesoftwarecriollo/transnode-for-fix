library transnode.user_service;

import 'package:angular/angular.dart';

@NgInjectableService()
class UserService {
  String _email;
  String _token;

  void set email(String email) {
    _email = email;
  }

  void set token(String token) {
    _token = token;
  }

  String get email => _email;
  String get token => _token;
  bool   get isAuthenticated => _token != null;
}
