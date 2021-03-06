part of transnode;

@InjectableService()
class ApiService {
  static String api_url;
  final Http _http;

  UserService _user;
  MessagesService _messages;
  Router _routes;

  ApiService(this._http, this._user, this._messages, this._routes) {
    if (is_production()) {
      api_url = production_path();
    } else {
      api_url = development_path();
    }
  }

  bool   is_production()    => ['127.0.0.1', 'localhost'].indexOf(window.location.hostname) == -1 ;
  String development_path() => "http://127.0.0.1:3000/";
  String production_path()  => "https://transnode-api.herokuapp.com/";
  String path() => api_url;

  Future<HttpResponse> request(String method, String url, { Map<String, dynamic> params, String data }) {
    url = api_url + url;
    return _http.call(method: method, url: url, data: data, params: params)
      .catchError((HttpResponse error) {
        switch (error.status) {
          case 404:
            return null;
          case 500:
            _messages.add('danger', "We're sorry, the server encountered a problem");
            break;
          case 401:
            if (!url.contains('session')) {
              _messages.add('danger', "We're sorry, but you need to login first");
              _user.cleanToken();
              _routes.go('home',{});
            }
            break;
          case 403:
            _messages.add('danger', "We're sorry, you are not authorized for this action");
            _routes.go('home',{});
            break;
          case 412:
            print(error);
            break;
          case 0:
            _messages.add('danger', "We're sorry, cannot connect to server");
            break;
          default:
            _messages.add('danger', "We're sorry, some unexpected error occurred");
        }

        throw error;
      });
  }
}
