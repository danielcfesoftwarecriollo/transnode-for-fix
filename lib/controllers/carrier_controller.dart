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
  var statesOfCountries;
  
  CarrierController(this._carrierService, this._routeProvider, this._router) {
    this.carriers = [];
    this.carrier = new Carrier();
    if (_isEditPath()) {
      var carrier_id = _routeProvider.parameters['carrierId'];
      _carrierService.get(carrier_id).then((_) => this.carrier = _);
//      load_form();
    } else if (_isShowPath()) {
      var carrier_id = _routeProvider.parameters['carrierId'];
      _carrierService.get(carrier_id).then((_) => this.carrier = _);
//      load_form();
    } else if (_isIndexPath()) {
      this.carriers = [];
//      this._load_carriers();
    }
    
  }


  void save() {
    if (this.carrier.is_valid()) {
      var response = this._carrierService.save(this.carrier);
      response.then((HttpResponse response) {
        if (response == null) return false;
        _router.go('carrier_list', {});
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


  bool get has_carriers => this.carriers.isNotEmpty;
  bool _isEditPath() => _routeProvider.routeName == 'carrier_edit';
  bool _isShowPath() => _routeProvider.routeName == 'carrier_show';
  bool _isNewPath() => _routeProvider.routeName == 'carrier_new';
  bool _isIndexPath() => _routeProvider.routeName == 'carrier_list';
}
