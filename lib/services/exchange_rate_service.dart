part of transnode;

@InjectableService()
class ExchangeRateService {
  static String url = '/exchange_rates';
  UserService user;
  MessagesService _messageServices;
  ApiService _api;

  ExchangeRateService(this._api, this.user, this._messageServices);

  Future index() {
    return _api.request('get', url);
  }

  Future<ExchangeRate> get(String exchangeRateId) {
    return _api.request("get", url + "/" + exchangeRateId.toString())
      .then((HttpResponse response) => response.data);
  }

  Future save(ExchangeRate exchangeRate) {
    String method;
    String parameters;
    String path;
    if (exchangeRate.is_new()) {
      method = 'post';
      parameters = params(exchangeRate);
      path = url;
    } else {
      method = 'put';
      parameters = params_update(exchangeRate);
      path = url + "/" + exchangeRate.id.toString() ; 
    }
    return _api.request(method, path, data: parameters)
      .catchError((HttpResponse response) {
        if (response.status == 422) {
          Map<String, List<String>> errors = JSON.decode(response.data);
          _messageServices.add("danger", "Review the errors in the form");
          exchangeRate.set_errors(errors);
        }
      });
  }

  String params_update(ExchangeRate exchangeRate) {
    return encode({
      "exchangeRate": exchangeRate.to_map(),
      "id": exchangeRate.id
    });
  }
  String params(ExchangeRate exchangeRate) {
    return encode({
      "exchangeRate": exchangeRate.to_map()
    });
  }
  String params_id(ExchangeRate exchangeRate) {
    return encode({
      "id": exchangeRate.id
    });
  }

  String encode(Map map) {
    return JSON.encode(map);
  }
}
