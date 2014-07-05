part of transnode;

@NgController(selector: '[carrier-controller]', publishAs: 'ctrl')
class ContactsController {
  @NgTwoWay("carrier")
  Contact carrier;
  @NgTwoWay("carriers")
  List<Contact> carrier;
  RouteProvider _routeProvider;
  Router _router;
  final CarrierService _carriertService;
  
  ContactsController(this._contactService, this._routeProvider, this._router) {
    this.carrier = new Carrier();
    if (_isEditPath()) {
      _contactService.get(_routeProvider.parameters['contactId']).then((_) =>
          this.contact = _);
      _config_data_form();
    } else if (_isIndexPath()) {
      this.contacts = [];
      this._load_contacts();
    }
    else{
      _config_data_form();
    }
    
    this.carrier = new Carrier();
    this.billTos = [];
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
    }
    this.step = 1;
    
  }

  bool get has_contacts => this.contacts.isNotEmpty;

  void save() {
    if (this.contact.is_valid()) {
      var response = this._contactService.save(this.contact);
      response.then((HttpResponse response) {
        if (response == null) return false;
        _router.go('carrier_list', {});
      });
    }
  }

  bool _isEditPath() => _routeProvider.routeName == 'carrier_edit';
  bool _isNewPath() => _routeProvider.routeName == 'carrier_new';
  bool _isIndexPath() => _routeProvider.routeName == 'carrier_list';
}
