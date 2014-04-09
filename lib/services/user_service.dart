part of transnode;

@NgInjectableService()
class UserService {
  String _email;
  String _token;
  
  UserService(){
    this._token = window.sessionStorage['user-token'];
    this._email = window.sessionStorage['user-email'];
  }
  
  void set email(String email) {
    _email = email;
    window.sessionStorage['user-email'] = email;
  }

  void set token(String token) {
    _token = token;
    window.sessionStorage['user-token'] = token;
  }
  
  void cleanToken(){
    _token = null;
    window.sessionStorage.clear();
  }

  String get email => _email;
  String get token => _token;
  bool   get isAuthenticated => _token != null;
}
