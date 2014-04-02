import 'package:angular/angular.dart';
import 'package:transnode/services/user_service.dart';

class HeadersWithToken extends HttpDefaultHeaders {
  UserService _userService;

  HeadersWithToken(this._userService);

  @override
  setHeaders(Map<String, String> headers, String method) {
    super.setHeaders(headers, method);

    if (_userService.isAuthenticated) {
      headers['Authorization'] = "Token token=${_userService.token}";
    }
  }
}
