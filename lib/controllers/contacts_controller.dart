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

  ContactsController(this._contactService, this._routeProvider, this._router) {
    this.contact = new Contact();
    if (_isEditPath()) {
      _contactService.get(_routeProvider.parameters['contactId']).then((_) =>
          this.contact = _);
    } else if (_isIndexPath()) {
      this.contacts = [];
      this._load_contacts();
    }
    else{

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

  void todo() {
    window.alert("TODO");
  }

  void _load_contacts() {
    var response = this._contactService.index();
    response.then((HttpResponse response) {

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
