part of transnode;

@NgController(
    selector: '[transnode]',
    publishAs: 'app')
class AppController {
  UserService _user_service;
  Router _router;

  AppController(this._user_service, this._router) {
    Keys.shortcuts({
        'Ctrl+1': ()=> _router.go('home', {}),
        'Ctrl+2': ()=> _router.go('customers', {}),
        'Ctrl+3': ()=> _router.go('shipment_order', {}),
        'Ctrl+4': ()=> _router.go('users', {}),
        'Ctrl+5': ()=> _router.go('test', {}),
    });
  }

  bool   get isAuthenticated => _user_service.isAuthenticated;
  String get email => _user_service.email;
}
