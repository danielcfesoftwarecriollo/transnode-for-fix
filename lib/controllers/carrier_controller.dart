part of transnode;

@Controller(selector: '[carrier-controller]', publishAs: 'ctrl')
class CarrierController {
  @NgTwoWay("carrier")
  Carrier carrier;
  @NgTwoWay("carriers")
  List<Carrier> carriers;
  RouteProvider _routeProvider;
  Router _router;
  final CarrierService _carrierService;
  final UserService _userService;
  final LocationService _locationService;
  final CityService _cityService;
  List locations;
  List countries;
  List cities;
  var asyncSelected;
  var asyncSelected2;
  var statesOfCountries;


  Lane laneHelper;
  List<Price> pricesHelper;
  Modal modal;
  ModalInstance modalInstance;
  Scope scope;
  User current_user;
  bool loadingCity;
   
  CarrierController(this._cityService, this._locationService,this._userService,this._carrierService,this.scope, this.modal, this._routeProvider, this._router) {
    this.carriers = [];
    this.cities = [];
    this.current_user = _userService.user;
    this.carrier = new Carrier();
    if (_isEditPath()) {
      var carrier_id = _routeProvider.parameters['carrierId'];
      _carrierService.get(carrier_id).then((_){ 
        this.carrier = _;
        loadCities();
        load_form();
      });      
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
  
  loadCitiesByName(String cityName){
    if(cityName.isNotEmpty){
      var response = _cityService.getCityByName(cityName.toString());
      return response.then((r) => r['cities']);
    }else{
      return [];
    }
  }
  
  onSelectTerm1(String cityId){
    var response = _cityService.get(cityId.toString());
    response.then((c){
      this.laneHelper.term1 = c;
    });    
  }
  
  onSelectTerm2(String cityId){
    var response = _cityService.get(cityId.toString());
    response.then((c){
      this.laneHelper.term2 = c;
    });    
  }  

  void open(String templateUrl) {
    modalInstance = modal.open(new ModalOptions(templateUrl:templateUrl),scope);
  }

  void modalAddNewLane(){
    this.laneHelper = new Lane();
    open('partials/carriers/modal/add_new_line.html');
  }

  void modalEditLane(Lane lane){
    this.laneHelper = lane;
    open('partials/carriers/modal/add_new_line.html');
  }

  void modalAddNewPriceList(){
    modalInstance.close(null);
    this.pricesHelper = [];
    this.addPrice();
    open('partials/carriers/modal/add_price_list.html');
  }

  void modalAddShowPriceList(Lane lane){
    this.laneHelper   = lane;
    this.pricesHelper = lane.prices;
    open('partials/carriers/modal/show_price_list.html');
  }

  bool validatePrices(){
    bool is_valid = true;
    this.pricesHelper.forEach((p){ 
      if(!p.is_valid()){
        is_valid = false;
      }
    });
    return is_valid;
  }
  
  void savePrices(){
    if(this.validatePrices()){
      this.laneHelper.prices = this.pricesHelper;
      modalInstance.close(null);
    }
  }

  void addPrice(){
    this.pricesHelper.add( new Price() );
  }

  void deletePrice(Price p){
    if (p.is_new()) {
      pricesHelper.remove(p);
    } else {
      p.delete();
    }
  }

  void saveLane(){
    Lane lane = this.laneHelper;
    if( this.laneHelper.full_valid() ){
      if( this.carrier.lanes.lastIndexOf(lane) == -1){
        this.carrier.lanes.add(lane);
      }
      modalInstance.close(null);
    }
  }

  loadCities(){
    this.carrier.locations.forEach((l)=>this.changeStates(l));
  }
  
  void load_form(){
    _carrierService.loadForm().then((response){
      this.countries = response['countries'];
      this.statesOfCountries = response['states_of_countries'];
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
  
  has_many_locations(){
    carrier.has_many_locations();
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

  void changeStates (Location currentLocation) {
     new Timer(const Duration(milliseconds: 1), () {
       this._locationService.getCitiesByState(currentLocation.stateId).then((cities){
         currentLocation.cities = cities;
       });
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
