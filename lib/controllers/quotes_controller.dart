part of transnode;

@Controller(selector: '[quote-controller]', publishAs: 'ctrl')
class QuotesController {
  RouteProvider _routeProvider;
  Router _router;
  final QuoteService _quoteService;
  @NgTwoWay("quote")
  Quote quote;
  List<Quote> quotes;

  List locations;
  List countries;
  bool opened;

  var asyncSelected;
  bool loadingLocations = false;

  QuotesController(this._quoteService, this._routeProvider, this._router) {
    this.quote = new Quote();

    if (_isEditPath() && _isShowPath()) {
      var quote_id = _routeProvider.parameters['quoteId'];
      _quoteService.get(quote_id).then((_) => this.quote = _);
      loadForm();
    } else if (_isIndexPath()) {
      this.quotes = [];
      this._load_quotes();
    }else if(_isNewPath()){
      loadForm();
    }
  }

  void loadForm(){
    _quoteService.loadForm().then((r){
      this.countries = r['countries'];
    });
  }

  load_customers(val){
    return _quoteService.load_customers(val);
  }

  onSelectCustomer(item, model, label){
    _quoteService.load_locations(model['value'].toString()).then((r){
      this.locations = r['locations'];
    });
  }

  void save(){
    if (this.quote.is_valid()) {
      var response = this._quoteService.save(this.quote);
      response.then((HttpResponse response) {
        print(response);
        if (response == null) return false;
       _router.go('quotes', {});
      });
    }
  }


  void _load_quotes() {
    var response = this._quoteService.index();
    response.then((HttpResponse response) {
      response.data.forEach(_add_quote);
      if (response == null) return false;
    });
  }

  void _add_quote(Map<String, dynamic> json) {
    Quote quote = new Quote();
    quote.loadWithJson(json);
    this.quotes.add(quote);
  }

  bool _isShowPath() => _routeProvider.routeName == 'quote_show';
  bool _isEditPath() => _routeProvider.routeName == 'quote_edit';
  bool _isNewPath() => _routeProvider.routeName == 'quote_new';
  bool _isIndexPath() => _routeProvider.routeName == 'quote_list';
}
