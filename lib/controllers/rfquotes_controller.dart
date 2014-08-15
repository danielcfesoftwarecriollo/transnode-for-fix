part of transnode;

@Controller(selector: '[rfquote-controller]', publishAs: 'ctrl')
class RfquotesController {
  RouteProvider _routeProvider;
  Router _router;
  final QuoteService _quoteService;
  final UsersService _usersService;
  @NgTwoWay("quote")
  Quote quote;
  List<Rfquote> quotes;

  List locations;
  List countries;
  bool opened = false;

 
  var idCRS;
  var idCustomer;
  String searchTime;

  var asyncSelectedCRS;
  var asyncSelected;
  bool loadingLocations = false;

  var format = 'dd-MMMM-yyyy';

  Map dateOptions = {
    'formatYear': 'yy',
    'startingDay': 1
  };

  RfquotesController(this._quoteService, this._routeProvider, this._router,this._usersService) {
    this.quote = new Rfquote();

    if (_isEditPath() || _isShowPath()) {
      var quote_id = _routeProvider.parameters['rfquoteId'];
      _quoteService.get(quote_id).then((_){ 
        this.quote = _; 
      });
      loadForm();
    } else if (_isIndexPath()) {
      this.quotes = [];
      this._load_quotes();
    }else if(_isNewPath()){
      loadForm();
    }
  }

  toggleCalendar(){
    this.opened = (this.opened)? false : true ;
  }

  void loadForm(){
    _quoteService.loadForm().then((r){
      this.countries = r['countries'];
    });
  }

  load_customers(val){
    return _quoteService.load_customers(val);
  }

  load_crs(val){
    return _usersService.search_csrs(val);
  }

  onSelectCustomer(item, model, label){
    _quoteService.load_locations(model['value'].toString()).then((r){
      this.locations = r['locations'];
      this.quote.loadCustomer(r);
    });
  }

  void changeTimesFilter() {
    new Timer(const Duration(milliseconds: 1), () {
      changeFilter();
    });
  }

  onSelectCustomerFilter(item, model, label){
    this.idCRS = model['value'].toString();
    changeFilter();
  }

  onSelectCrsFilter(item, model, label){
    this.idCRS = model['value'].toString();
    changeFilter();
  }

  changeFilter(){
    _quoteService.seachQuotes(_filtersIndexToJson()).then((r){
      r.data;
    });
  }
  _filtersIndexToJson(){
    Map map = {
      'crs':this.idCRS,
      'customer':this.idCustomer,
      'time':this.searchTime
    };
    return _encode(map);
  }
  String _encode(Map map) {
    return JSON.encode(map);
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

  void deleteLine(Line l){
    l.delete();
  }

  void _load_quotes() {
    var response = this._quoteService.index();
    response.then((HttpResponse response) {
      response.data.forEach(_add_quote);
      if (response == null) return false;
    });
  }

  void _add_quote(Map<String, dynamic> json) {
    Rfquote quote = new Rfquote();
    quote.loadWithJson(json);
    this.quotes.add(quote);
  }

  bool _isShowPath() => _routeProvider.routeName == 'rfquote_show';
  bool _isEditPath() => _routeProvider.routeName == 'rfquote_edit';
  bool _isNewPath() => _routeProvider.routeName == 'rfquote_new';
  bool _isIndexPath() => _routeProvider.routeName == 'rfquotes';
}
