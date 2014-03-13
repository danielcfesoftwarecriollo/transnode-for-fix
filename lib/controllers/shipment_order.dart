library transnode.app_controller;

import 'package:angular/angular.dart';

@NgController(
    selector: '[shipment_order]',
    publishAs: 'app')
class AppController {
  AppController();

  bool isAuthenticated() {
    return _api.isAuthenticated();
  }

  String user_email() {
    return _api.user.email;
  }
}