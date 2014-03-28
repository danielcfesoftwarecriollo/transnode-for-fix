import 'package:angular/angular.dart';
import 'package:transnode/services/user_service.dart';

class CustomHeader extends HttpDefaultHeaders {
  User user;

  @override
  setHeaders(Map<String, String> headers, String method) {
    super.setHeaders(headers, method);
    if (this.user != null && this.user.token != "") {
      headers['Authorization'] = "Token token=${this.user.token}";
    }
  }

  void setToken(User user) {
    this.user = user;
    this.setHeaders({}, "GET");
  }
  void cleanToken() {
    this.setHeaders({}, "GET");
  }
}
