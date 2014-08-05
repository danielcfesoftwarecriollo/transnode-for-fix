part of transnode;

@InjectableService()
class QuoteService {
  static String url = '/quotes';
  UserService user;
  MessagesService _messageServices;
  ApiService _api;

  QuoteService(this._api, this.user, this._messageServices);

  Future index() {
    return _api.request('get', url);
  }
  
  Future<Quote> get(String quoteId) {
    return _api.request("get", url + "/" + quoteId.toString())
      .then((HttpResponse response) => _loadQuote(response.data));
  }

  Future load_customer(String query_str){
    String urlService = "/customer_by_id/"+query_str;
    return load_data(urlService);    
  }

  Future load_data(String stringUrl) {
    return _api.request("post", url + stringUrl)
      .then((HttpResponse response) => response.data);
  }

  load_customers(val) {
   return _api.request("post",'http://localhost:3000/shipments/customers/'+val)
    .then((response){
      return response.data['customers'];
    });
  }

  Future save(Quote quote) {
    String method;
    String parameters;
    String path;
    if (quote.is_new()) {
      method = 'post';
      parameters = params(quote);
      path = url;
    } else {
      method = 'put';
      parameters = params_update(quote);
      path = url + "/" + quote.id.toString() ; 
    }
    return _api.request(method, path, data: parameters)
      .catchError((HttpResponse response) {
        if (response.status == 422) {
          Map<String, List<String>> errors = JSON.decode(response.data);
          _messageServices.add("danger", "Review the errors in the form");
          quote.set_errors(errors);
        }
      });
  }

  Quote _loadQuote(map) {
    Quote quote = new Quote();
    quote.loadWithJson(map);
    return quote;
  }

  String params_update(Quote quote) {
    return encode({
      "quote": quote.to_map(),
      "id": quote.id
    });
  }
  String params(Quote quote) {
    return encode({
      "quote": quote.to_map()
    });
  }
  String params_id(Quote quote) {
    return encode({
      "id": quote.id
    });
  }

  String encode(Map map) {
    return JSON.encode(map);
  }
}
