library transnode.app_controller;

import 'package:angular/angular.dart';
import 'package:transnode/services/user_service.dart';

@NgController(
    selector: '[transnode]',
    publishAs: 'app')
class AppController {
  UserService _user_service;

  AppController(this._user_service);

  bool get isAuthenticated => _user_service.isAuthenticated;
  String get email => _user_service.email;
}
