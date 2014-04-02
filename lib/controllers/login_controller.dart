library transnode.login_controller;

import 'package:angular/angular.dart';
import 'package:transnode/services/session_service.dart';
import 'package:transnode/services/messages_service.dart';

@NgController(selector: '[login-controller]', publishAs: 'login')
class LoginController {
  SessionService _session_service;
  MessagesService _messages_service;

  String email    = 'a@a.aa';
  String password = 'a';

  LoginController(this._session_service, this._messages_service);

  void signIn() {
    _session_service.signIn(email, password).then((data) {
      _messages_service.add("You successfully signed in, $email");
    }).catchError((errors) {
      _messages_service.add('not this time');
    });
  }

  void signOut() {
    _session_service.signOut();
  }
}
