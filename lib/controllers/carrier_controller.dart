part of transnode;

@NgController(selector: '[carrier-controller]', publishAs: 'ctrl')
class CarrierController {
  @NgTwoWay("carrier")
  Carrier carrier;
  @NgTwoWay("carriers")
  List<Carrier> carriers;
  RouteProvider _routeProvider;
  Router _router;
  final CarrierService _carrierService;
  List locations;
  List countries;
  List cities;
  var statesOfCountries;
  
  CarrierController(this._carrierService, this._routeProvider, this._router) {
    this.carriers = [];
    this.cities = [];
    this.carrier = new Carrier();
    if (_isEditPath()) {
      var carrier_id = _routeProvider.parameters['carrierId'];
      _carrierService.get(carrier_id).then((_) => this.carrier = _);
      load_form();
    } else if (_isShowPath()) {
      var carrier_id = _routeProvider.parameters['carrierId'];
      _carrierService.get(carrier_id).then((_) => this.carrier = _);
      load_form();
    } else if (_isIndexPath()) {
      this.carriers = [];
      this._load_carriers();
    } else if (_isNewPath()){
      load_form();
    }
    
  }

  void load_form(){
    _carrierService.loadForm().then((response){
      this.countries = response['countries'];
      this.statesOfCountries = response['states_of_countries'];
      load_cities(response['cities']);
    });
    new Timer(const Duration(milliseconds: 1000), () {
      List countries = querySelectorAll('.countries');
      countries.forEach((element) => dispachChange(element));
    });    
  }
  
  void dispachChange(SelectElement element){
    Event changeE = new Event('change');
    element.dispatchEvent(changeE);
  }
  
  void load_cities(List cities ){
    cities.forEach(( city_attr ){
      City new_city = new City();
      new_city.loadWithJson(city_attr);
      
      this.cities.add(new_city);
    });
  }
  
  void save(){
    if (this.carrier.full_validation()) {
      var response = this._carrierService.save(this.carrier);
      response.then((HttpResponse response) {
        print(response);
        if (response == null) return false;
       _router.go('carriers', {});
      });
    }
  }

  void add_lane() {
   this.carrier.new_empty_lane();
  }

  void add_location() {
    this.carrier.new_empty_location();
  }
  
  void delete_location(Location location) {
    this.carrier.delete_location(location);
  }

  void delete(Carrier carrier) {
    if (window.confirm("Are you sure to delete this item?")) {
      _carrierService.delete(carrier.id.toString()).then((_){
        carriers.remove(carrier);
      });
    } else {
      print("false ");
    }
  }
  
  void changeCountries (currentLocation) {
     new Timer(const Duration(milliseconds: 1), () {
       print(currentLocation.countryId);
       List x = this.getStatesByCountry(currentLocation.countryId.toString());
       currentLocation.states = x;
       print(currentLocation.states);
     });
  }
  
  List getStatesByCountry(String countryId) {
    if(countryId.toString() != 'null'){
      return this.statesOfCountries[countryId]['states'];
    }else{
      return [];
    }
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
  
  bool get has_carriers => this.carriers.isNotEmpty;
  bool _isEditPath() => _routeProvider.routeName == 'carrier_edit';
  bool _isShowPath() => _routeProvider.routeName == 'carrier_show';
  bool _isNewPath() => _routeProvider.routeName == 'carrier_new';
  bool _isIndexPath() => _routeProvider.routeName == 'carriers';
}
