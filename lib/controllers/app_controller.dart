library transnode.app_controller;

import 'package:angular/angular.dart';
import 'package:transnode/services/api_service.dart';

@NgController(
    selector: '[transnode]',
    publishAs: 'app')
class AppController {
  ApiService _api;

  AppController(this._api);

  bool isAuthenticated() {
    return _api.isAuthenticated();
  }

  String user_email() {
    return _api.user.email;
  }
}