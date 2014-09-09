part of transnode;

@Controller(selector: '[searchclp-controller]', publishAs: 'ctrl')
class SearchclpController {
  RouteProvider _routeProvider;
  Router _router;
  final CarrierService _carrierService;
  final QuoteService _quoteService;
  final CityService _cityService;

  @NgTwoWay("carriers")

  List<Shipment> shipments;
  List<Carrier> carriers;
  List<Carrier> carriersLP;
  List<City> cities;
  List<Quote> citiesToAux;
  List<Quote> citiesFromAux;

  Quote cityToSelected;
  Quote cityFromSelected;
  Quote quoteSelected;
  Shipment shipmentSelected;
  var asyncSelected;
  List formQuotes;
  Map loading;
  String skids;


  // Lane laneHelper;
  // List<Price> pricesHelper;
  // Modal modal;
  // ModalInstance modalInstance;
  Scope scope;

  
  SearchclpController(this._carrierService, this._cityService ,this.scope,this._routeProvider, this._quoteService, this._router) {
    this.carriers = [];
    this.cities = [];
    this.citiesToAux = [];
    this.citiesFromAux = [];
    this.loading = {'From': true, 'To': true};
   if( _isSearchCLP()){
      this.carriersLP = [];
      this.carriers = [];
      this.formQuotes = [];
      this._load_carriers();
      this._load_quotes_form();
    }
    
  }

  void _add_quote(Map<String, dynamic> json) {
    Quote quote = new Quote();
    quote.loadWithJson(json);
    this.formQuotes.add(quote);
  }
  
  void _load_quotes_form() {
    var response = this._quoteService.index();
    response.then((HttpResponse response) {
      response.data.forEach(_add_quote);
      if (response == null) return false;
    });
  }
  
  void _add_carrier(Map<String, dynamic> json) {
    Carrier carrier = new Carrier();
    carrier.loadWithJson(json);
    this.carriers.add(carrier);
  }

  void _load_carriers() {
    var response = this._carrierService.index();
    response.then((HttpResponse response) {
      response.data.forEach(_add_carrier);
      if (response == null) return false;
    });
  }

  void to_index(){
    _router.go('carriers', {});
  }
  
  
  bool _isSearchCLP() => _routeProvider.routeName == 'search_clp';

  void dispachChange(SelectElement element){
    Event changeE = new Event('change');
    element.dispatchEvent(changeE);
  }

  void onSelectCity( Selected, model){
    print(model);
  }

  get_cities(destinyCities,value){
    var response = this._cityService.get_cities_by_name(value.toString());
    return response.then((r) =>loadCitiesIn(destinyCities,r));
  }
  
  getCarriersLanePrice(queryString){
    var response = this._carrierService.getCarriersLanePrice(queryString.toString());
    return response.then((r) =>loadCitiesIn(r));
  }
  
  searchCLP(){
    var data = [this.quoteSelected,this.shipmentSelected,this.cityFromSelected,this.cityToSelected,this.skids];
    getCarriersLanePrice(HelperUrl.parseToUrl(data));
  }
  
  
  
  loadCitiesIn(List cities, citiesMap ){
    cities = [];
    citiesMap.forEach(( city_attr ){
      City new_city = new City();
      new_city.loadWithJson(city_attr);      
      cities.add(new_city);
    });
    return cities;
  }

  void save(){
//    if (this.carrier.full_validation()) {
//      var response = this._carrierService.save(this.carrier);
//      response.then((HttpResponse response) {
//        print(response);
//        if (response == null) return false;
//       _router.go('carriers', {});
//      });
//    }
  }

}
