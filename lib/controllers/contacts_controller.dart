part of transnode;

@NgController(selector: '[contact-controller]', publishAs: 'ctrl')
class ContactsController {
  @NgTwoWay("contact")
  Contact contact;
  @NgTwoWay("contacts")
  List<Contact> contacts;
  RouteProvider _routeProvider;
  Router _router;
  final ContactService _contactService;
  
  @NgTwoWay("branchs")
  List branchs;
  @NgTwoWay("locations")
  List locations;

  ContactsController(this._contactService, this._routeProvider, this._router) {
    this.contact = new Contact();
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
  }

  bool get has_contacts => this.contacts.isNotEmpty;

  void save() {
    if (this.contact.is_valid()) {
      var response = this._contactService.save(this.contact);
      response.then((HttpResponse response) {
        if (response == null) return false;
        _router.go('contact_list', {});
      });
    }
  }

  void _config_data_form(){
    _contactService.form().then((data){
      this.locations = data["locations"];
      this.branchs =  data["branchs"];
    });
  }

  void _load_contacts() {
    var response = this._contactService.index();
    response.then((HttpResponse response) {
      print(response.data);
      response.data.forEach(_add_contact);
      if (response == null) return false;
    });
  }
  
  void _add_contact(Map<String, dynamic> json) {
    Contact contact = new Contact();
    contact.loadWithJson(json);
    this.contacts.add(contact);
  }

  bool _isEditPath() => _routeProvider.routeName == 'contact_edit';
  bool _isNewPath() => _routeProvider.routeName == 'contact_new';
  bool _isIndexPath() => _routeProvider.routeName == 'contact_list';
}
