library transnode.user_service;

import 'package:angular/angular.dart';

@NgInjectableService()
class User {
  String email;
  String token;

  bool isAuthenticated() {
    return token != null;
  }
}