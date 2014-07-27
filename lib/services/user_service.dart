part of transnode;

@InjectableService()
class UserService {
  String _email;
  String _token;

  UserService(){
    this._token = window.localStorage['user-token'];
    this._email = window.localStorage['user-email'];
  }

  void set email(String email) {
    _email = email;
    window.localStorage['user-email'] = email;
  }

  void set token(String token) {
    _token = token;
    window.localStorage['user-token'] = token;
  }

  void cleanToken() {
    _token = null;
    window.localStorage.clear();
  }

  String get email => _email;
  String get token => _token;
  bool   get isAuthenticated => _token != null;
}
