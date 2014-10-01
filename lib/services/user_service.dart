part of transnode;

@InjectableService()
class UserService {
  String _email;
  String _token;
  String _user;

  UserService(){
    this._token = window.localStorage['user-token'];
    this._email = window.localStorage['user-email'];
    this._user =  window.localStorage['user'];
  }

  void set user(User user) {
    _user = JSON.encode(user);
    window.localStorage['user'] = _user;
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
  
  User loadUser( json_user ){
    User user = new User();
    user.loadWithJson(json_user);
    return user;
  }

  User get user => loadUser(JSON.decode(_user));
  String get email => _email;
  String get token => _token;
  bool   get isAuthenticated => _token != null;
}
