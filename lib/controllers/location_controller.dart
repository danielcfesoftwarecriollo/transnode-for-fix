part of  transnode;

@Controller(selector: '[location-controller]', publishAs: 'ctrlLocation')
class LocationController{
  @NgTwoWay("customer")
  Customer customer;
  RouteProvider _routeProvider;
  Router _router;
  final CustomerService _customerService;
  
  // helpers
  @NgTwoWay("customerIdToAdd")
  int customerIdToAdd;
  List countries;
  var statesOfCountries;
  List locations;
  List sources;
  List cities;
  
  LocationController(this._customerService, this._routeProvider, this._router){
    this.customer = new Customer();
      this.cities = [];
//      this.billTos = [];
      
      new Timer(const Duration(milliseconds: 200), () {        
        String customer_id = querySelector('#customerAdd').value;
        _customerService.get(customer_id).then((_){ 
          this.customer = _;
          this.customer.locations.add(new Location());
              });
        load_form();
      });
  }

  void load_form(){
    _customerService.loadForm().then((response){
      this.countries = response['countries'];
      this.statesOfCountries = response['states_of_countries'];
      load_cities(response['cities']);
    });
    
    new Timer(const Duration(milliseconds: 1000), () {
      List countries = querySelectorAll('.countries');
      countries.forEach((element) => dispachChange(element));
    });
  }
  
  void load_cities(List cities ){
    cities.forEach(( city_attr ){
      City new_city = new City();
      new_city.loadWithJson(city_attr);      
      this.cities.add(new_city);
    });
  }
    
  void dispachChange(SelectElement element){
    Event changeE = new Event('change');
    element.dispatchEvent(changeE);
  }

  void add_location() {
    this.customer.new_empty_location();
  }

  void delete_location(Location location) {
    this.customer.delete_location(location);
  }
  
  Customer _loadCustomer(map) {
    Customer customer = new Customer();
    customer.loadWithJson(map);
    return customer;
  }

  void save(modal){
    if (this.customer.valid_step1()) {
      var responseSave = this._customerService.save(this.customer);
      responseSave.then((HttpResponse response) {
        update_customer(response);
        modal.close(null);
      });
    }
  }
  
  void update_customer( response ){
    if(response.data.length > 0){
      Customer c = _loadCustomer(response.data);
      this.customer = c;
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
  
  void saveLocationNew(modalInstance){
    this.save(modalInstance);   
  }
  
  has_many_locations() => customer.has_many_locations();


}
