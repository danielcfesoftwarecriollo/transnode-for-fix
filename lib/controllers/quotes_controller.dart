part of transnode;

@Controller(selector: '[quote-controller]', publishAs: 'ctrl')
class QuotesController {
  RouteProvider _routeProvider;
  Router _router;
  final QuoteService _quoteService;
  final UsersService _usersService;
  @NgTwoWay("quote")
  Quote quote;
  List<Quote> quotes;

  List locations;
  List countries;
  bool opened = false;

 
  var idCRS;
  var idCustomer;
  String searchTime;

  var asyncSelectedCRS;
  var asyncSelected;
  bool loadingLocations = false;
  Modal modal;
  Scope scope;
  ModalInstance modalInstance;
  var format = 'dd-MMMM-yyyy';

  Map dateOptions = {
    'formatYear': 'yy',
    'startingDay': 1
  };

  QuotesController(this._quoteService, this._routeProvider, this._router,this._usersService, this.scope, this.modal) {
    this.quote = new Quote();
    this.searchTime = "TODAY";

    if (_isEditPath() || _isShowPath()) {
      var quote_id = _routeProvider.parameters['quoteId'];
      _quoteService.get(quote_id).then((_){ 
        this.quote = _; 
      });
      loadForm();
    } else if (_isIndexPath()) {
      this.quotes = [];
      new Timer(const Duration(milliseconds: 30), () {
        this.searchRFQ();
      });
    }else if(_isNewPath()){
      loadForm();
    }
  }
  
  getSelected(x, ModalInstance modalInstanceSPL){
    if(x != null){
      QuoteCost qc= _loadCostWithCarierLane(x);
      this.quote.costs.add(qc);
      modalInstance.close(null);
    }
  }

  QuoteCost _loadCostWithCarierLane(carrierLane){
    QuoteCost qc = new QuoteCost();
    qc.vendor = carrierLane.carrier;
    qc.what = carrierLane.lane;
    qc.number = carrierLane.lane.prices.first.price;  
    qc.currency = "CAD";
    return qc;
  }

  void open(String templateUrl) {
    modalInstance = modal.open(new ModalOptions(templateUrl:templateUrl,windowClass:'searchclp'),scope);
  }

  modalSearchCPL(){
    open('partials/carriers/search_clp.html');
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
    this.idCustomer = null;
    return _quoteService.load_customers(val);
  }

  load_crs(val){
    this.idCRS = null;
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
      // changeFilter();
    });
  }

  onSelectCustomerFilter(item, model, label){
    this.idCustomer = model['value'].toString();
    // changeFilter();
  }

  onSelectCrsFilter(item, model, label){
    this.idCRS = model['value'].toString();
    // changeFilter();
  }

  List _filtersSearchRFQ(){
    return [this.idCRS,this.searchTime, this.idCustomer,'RFQ'];
  }
  
  searchRFQ(){
    List data = _filtersSearchRFQ();
    var aux = HelperUrl.parseToUrl(data);
    this.quotes = [];
    _quoteService.getSearchQuote(aux).then((r){
      List listAux = r.data['quotes'];
      listAux.forEach(_add_quote);
    });
  }
  
  changeFilter(){
    this.searchRFQ();
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
    Quote quote = new Quote();
    quote.loadWithJson(json);
    this.quotes.add(quote);
  }

  bool _isShowPath() => _routeProvider.routeName == 'quote_show';
  bool _isEditPath() => _routeProvider.routeName == 'quote_edit';
  bool _isNewPath() => _routeProvider.routeName == 'quote_new';
  bool _isIndexPath() => _routeProvider.routeName == 'quotes';
}
