part of transnode;

@Controller(selector: '[login-controller]', publishAs: 'login')
class LoginController {
  SessionService _sessionService;
  MessagesService _messagesService;

  String email;
  String password;

  LoginController(this._sessionService, this._messagesService);

  void signIn() {
    _sessionService.signIn(email, password).then((data) {
      _messagesService.add('success', "You successfully signed in, $email");
    }).catchError((errors) {
      _messagesService.add('warning', 'Wrong email or password');
    });
  }

  void signOut() {
    _sessionService.signOut();
  }
}
