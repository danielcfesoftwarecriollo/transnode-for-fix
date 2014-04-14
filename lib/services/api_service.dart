part of transnode;

@NgInjectableService()
class ApiService {
  static String api_url;
  final Http _http;

  UserService _user;
  MessagesService _messages;

  ApiService(this._http, this._user, this._messages) {
    if (is_production()) {
      api_url = production_path();
    } else {
      api_url = development_path();
    }
  }

  bool   is_production()    => window.location.hostname != '127.0.0.1';
  String development_path() => "http://0.0.0.0:3000";
  String production_path()  => "http://api.apps.welkeglobal.com/";

  Future<HttpResponse> request(String method, String url, { Map<String, dynamic> params, String data }) {
    url = api_url + url;
    return _http.call(method: method, url: url, data: data, params: params)
      .catchError((HttpResponse error) {
        switch (error.status) {
          case 404:
          case 500:
            _messages.add("We're sorry, the server encountered a problem");
            break;
          case 401:
            _messages.add("We're sorry, but you need to login first");
            break;
          case 403:
            _messages.add("We're sorry, you are not authorized for this action");
            break;
          case 0:
            _messages.add("We're sorry, cannot connect to server");
            break;
          default:
            _messages.add("We're sorry, some unexpected error occurred");
        }
        throw error;
      });
  }
}
