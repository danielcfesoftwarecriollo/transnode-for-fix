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
  // Modal modal;
  // ModalInstance modalInstance;
  // Scope scope;

  var asyncSelected;
  bool loadingLocations = false;

  QuotesController(this._quoteService, this._routeProvider, this._router) {
    this.quote = new Quote();
    opened = true;
    if (_isEditPath()) {
    
    } else if (_isIndexPath()) {
      this.quotes = [];
    }else{
    }
  }

  load_customers(val){
    return _quoteService.load_customers(val);
  }

  onSelectCustomer(item, model, label){
    
  }

  bool _isEditPath() => _routeProvider.routeName == 'quote_edit';
  bool _isNewPath() => _routeProvider.routeName == 'quote_new';
  bool _isIndexPath() => _routeProvider.routeName == 'quote_list';
}
