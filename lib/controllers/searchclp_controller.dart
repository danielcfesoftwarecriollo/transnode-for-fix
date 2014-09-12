
part of transnode;

@Controller(selector: '[searchclp-controller]', publishAs: 'ctrl')
class SearchclpController {
  RouteProvider _routeProvider;
  Router _router;
  final CarrierService _carrierService;
  final ShipmentService _shipmentService;
  final QuoteService _quoteService;
  final CityService _cityService;
  final MailService _mailService;
  @NgTwoWay("carriers")

  List<Shipment> shipments;
  List<Carrier> carriers;
  List<Carrier> carriersLP;
  List<City> cities;
  List<Quote> citiesToAux;
  List<Quote> citiesFromAux;
  List carrierPrices;
  List carrierPrices2;
  City cityToSelected;
  City cityFromSelected;
  Quote quoteSelected;
  Carrier carrierSelected;
  Shipment shipmentSelected;
  var asyncSelected;
  List formQuotes;
  Map loading;
  String skids;
  int MAX_PRICES;
  Mail mailHelper;

  // Lane laneHelper;
  // List<Price> pricesHelper;
  Modal modal;
  ModalInstance modalInstance;
  Scope scope;

  
  SearchclpController(this._mailService,this._carrierService, this._cityService, this._shipmentService , this.modal,this.scope,this._routeProvider, this._quoteService, this._router) {
    MAX_PRICES = 7;
    this.carriers = [];
    this.cities = [];
    this.citiesToAux = [];
    this.citiesFromAux = [];

    this.loading = {'From': true, 'To': true, 'customer': false};
   if( _isSearchCLP()){
      this.carriersLP = [];
      this.carriers = [];
      this.formQuotes = [];
      this._load_carriers();
      this._load_quotes_form();
      this.searchCLP();
      this.searchCLPWithName();
      this.loadShipments();
    }
    
  }

  loadShipments(){
    this._shipmentService.index()
    ..then((r){
      this.shipments = [];
      r.data.forEach((s){
        this.shipments.add(LoadModel.loadShipment(s));
      });
    });
  }
  

  sendMail(){
    var request = _mailService.send_mail(this.mailHelper);
    request.then((r){
      print(r);
    });
  }

  void open(String templateUrl) {
    modalInstance = modal.open(new ModalOptions(templateUrl:templateUrl),scope);
  }

  void openModalMail(emailTo){
    this.mailHelper = new Mail();
    this.mailHelper.to = emailTo;
    open('partials/modals/send_mail.html');
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
    Selected = model;
  }
  
  void onSelectCarrier(model){
    print(model);
  }

  loadLaneQuote(){
    new Timer(const Duration(milliseconds: 1000), () {
      this.quoteSelected;
      var request = _quoteService.get(this.quoteSelected.id.toString());
      request.then((quote){
        loadCitiesByQuote(quote);
      });
    });
  }
  
  loadCitiesByQuote(Quote quote){
    this._cityService.get(quote.fromCityId.toString()).then((c){
      this.cityFromSelected = c;
    });
    this._cityService.get(quote.toCityId.toString()).then((c){
      this.cityToSelected = c;
    });
    this.skids = quote.totalPcs().toString();
  }
  
  get_cities(destinyCities,value){
    var response = this._cityService.get_cities_by_name(value.toString());
    return response.then((r) =>loadCitiesIn(destinyCities,r));
  }

  loadCarriersByString(val){
    var response = this._carrierService.getCarriersByName(val.toString());
    return response.then((r) =>r);
  }

  getCarriersLanePrice(queryString){
    var response = this._carrierService.getCarriersLanePrice(queryString.toString());
    return response.then((r){
      loadPricesCarriers(r['carriers']);
    });
  }
  
  getCarriersLanePriceToTable2(queryString){
    var response = this._carrierService.getCarriersLanePrice(queryString.toString());
    return response.then((r){
      loadPricesCarriers2(r['carriers']);
    });
  }
  
  getLeftPrices(currentLenght){
    return currentLenght - this.MAX_PRICES;
  }

  loadPricesCarriers(mapData){
    this.carrierPrices = [];
    mapData.forEach((cp){
      this.carrierPrices.add({'carrier':LoadModel.loadCarrier(cp['carrier']), 'lane': LoadModel.loadLane(cp['lane'])});
    });
  }
  
  loadPricesCarriers2(mapData){
    this.carrierPrices2 = [];
    mapData.forEach((cp){
      this.carrierPrices2.add({'carrier':LoadModel.loadCarrier(cp['carrier']), 'lane': LoadModel.loadLane(cp['lane'])});
    });
  }
  
  idNotNull(obj){
    if(obj == null){
      return null;
    }else{
      return obj.id;
    }
  }

  searchCLP(){
    var data = [idNotNull(this.quoteSelected), idNotNull(this.shipmentSelected), idNotNull(this.cityFromSelected), idNotNull(this.cityToSelected), this.skids];
    var aux = HelperUrl.parseToUrl(data);
    getCarriersLanePrice(aux);
  }
  
  searchCLPWithName(){
    var data = [idNotNull(this.quoteSelected), idNotNull(this.shipmentSelected), idNotNull(this.cityFromSelected), idNotNull(this.cityToSelected), this.skids];
    var aux = HelperUrl.parseToUrl(data);
    getCarriersLanePriceToTable2(aux);
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

  deleteItem(List list, item){
    list.remove(item);
  }

}
