library transnode.login_controller;

import 'package:angular/angular.dart';
import 'package:transnode/services/api_service.dart';

@NgController(
    selector: '[login]',
    publishAs: 'login')
class LoginController {
  ApiService _api;

  // default values to not fill form every time
  String email;
  String password;
  String message;

  LoginController(this._api);

  void signIn() {
    message = null;
    _api.signIn(email, password).catchError((error) {
      message = error;
    });
  }

  void signOut() {
    _api.signOut();
  }

  bool haveMessage() {
    return message != null;
  }
}
