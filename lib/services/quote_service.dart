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
      .then((HttpResponse response) => _loadQuote(response));
  }
  Future loadForm() {
    return _api.request("post", url + "/form")
      .then((HttpResponse response) => response.data);
  }

  Future seachQuotes(data) {
    return _api.request("post", "/users/search", data:data )
           .then((_) => _ );
  }


  Future<List> getSearchQuote(String queryString) {
    return _api.request("get", url + "/search" + queryString.toString())
       .then((HttpResponse response){ 
        return response;
      });
  }

  Future load_customer(String query_str){
    String urlService = "/customer_by_id/"+query_str;
    return load_data(urlService);    
  }

  Future load_locations(String query_str){
    String urlService = "/customer_locations/"+query_str;
    return load_data(urlService);    
  }

  Future load_data(String stringUrl) {
    return _api.request("post", url + stringUrl)
      .then((HttpResponse response) => response.data);
  }

  load_customers(val) {
   return _api.request("post",url + '/customers/'+val)
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

  Quote _loadQuote(response) {
    if(response == null){
      return null;
    }
    var map = response.data;
    Quote quote = new Quote();
    quote.loadWithJson(map);
    quote.checkTotal();
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
