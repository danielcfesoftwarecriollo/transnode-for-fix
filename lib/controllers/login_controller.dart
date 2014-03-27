library transnode.login_controller;

import 'package:angular/angular.dart';
import 'package:transnode/services/session_services.dart';

@NgController(
    selector: '[login]',
    publishAs: 'login')
class LoginController {
  SessionService _session_server;

  String email;
  String password;
  String message;

  LoginController(this._session_server);

  void signIn() {
    message = null;
    _session_server.signIn(email, password).catchError((error) {
      message = error;
    });
  }

  void signOut() {
    _session_server.signOut();
  }

  bool haveMessage() {
    return message != null;
  }
}
