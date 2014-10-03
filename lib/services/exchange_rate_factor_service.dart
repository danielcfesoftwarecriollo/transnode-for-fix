part of transnode;

@InjectableService()
class ExchangeRateFactorService {
  static String url = '/exchange_rate_factors';
  UserService user;
  MessagesService _messageServices;
  ApiService _api;

  ExchangeRateFactorService(this._api, this.user, this._messageServices);

  Future index() {
    return _api.request('get', url);
  }
  
  Future getFactorExchange(String from, String to){
    return _api.request("get", url + "/exchange_rate/" + from.toString() + '/' + to.toString())
         .then((HttpResponse response) { 
            return response.data;
          });
  }
  
  Future<ExchangeRateFactor> get(String exchangeRateFactorId) {
    return _api.request("get", url + "/" + exchangeRateFactorId.toString())
      .then((HttpResponse response) => response.data);
  }

  Future save(ExchangeRateFactor exchangeRateFactor) {
    String method;
    String parameters;
    String path;
    if (exchangeRateFactor.is_new()) {
      method = 'post';
      parameters = params(exchangeRateFactor);
      path = url;
    } else {
      method = 'put';
      parameters = params_update(exchangeRateFactor);
      path = url + "/" + exchangeRateFactor.id.toString() ; 
    }
    return _api.request(method, path, data: parameters)
      .catchError((HttpResponse response) {
        if (response.status == 422) {
          Map<String, List<String>> errors = JSON.decode(response.data);
          _messageServices.add("danger", "Review the errors in the form");
          exchangeRateFactor.set_errors(errors);
        }
      });
  }

  String params_update(ExchangeRateFactor exchangeRateFactor) {
    return encode({
      "exchangeRateFactor": exchangeRateFactor.to_map(),
      "id": exchangeRateFactor.id
    });
  }
  String params(ExchangeRateFactor exchangeRateFactor) {
    return encode({
      "exchangeRateFactor": exchangeRateFactor.to_map()
    });
  }
  String params_id(ExchangeRateFactor exchangeRateFactor) {
    return encode({
      "id": exchangeRateFactor.id
    });
  }

  String encode(Map map) {
    return JSON.encode(map);
  }
}
