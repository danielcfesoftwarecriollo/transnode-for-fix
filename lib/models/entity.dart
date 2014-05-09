part of transnode;

class Entity extends RecordModel {
  String name;
  String city;
  String state;
  String zip;
  String creditNote;
  double creditLimit;
  double balance;
  bool requiredPod;
  String currency;
  int _rating;
  String note;
  String taxId;
  String invoiceMethod;
  String terms;
  String importCustomsBrokerId;
  String exportCustomsBrokerId;
  String currencyRiskFactor;
  String salesRepId;
  String territoryId;
  List roles;
  Map _roles_map;
  List<Location> locations;
  List<Contact> contacts;

  int get rating => _rating;

  void set rating(value) {
    if (value == null) {
      _rating = null;
    } else {
      _rating = value.toInt();
    }
  }

  Location new_empty_location() {
    Location location = new Location();
    this.rating = 0;
    this.locations.add(location);
    return location;
  }

  Contact new_empty_contact() {
    Contact contact = new Contact();
    this.contacts.add(contact);
    return contact;
  }

  void delete_location(Location location) {
    locations.remove(location);
  }

  void delete_contact(Contact contact) {
    contacts.remove(contact);
  }

  bool count_locations() {
    return locations.length > 1;
  }

  bool count_contacts() {
    return contacts.length > 1;
  }

  List<Map> locations_to_map() {
    List<Map> locations_map = [];
    this.locations.forEach((location) => locations_map.add(location.to_map()));
    return locations_map;
  }

  List<Map> contacts_to_map() {
    List<Map> contacts_map = [];
    this.contacts.forEach((contact) => contacts_map.add(contact.to_map_customer(
        )));
    return contacts_map;
  }

  List roles_to_list() {
    List roles_return = [];
    _roles_map.forEach((role, has_role) {
      if (has_role) roles_return.add(role);
    });
    return roles_return;
  }

  void loadWithJson(Map<String, dynamic> map) {
    super.loadWithJson(map);
    load_map_roles();
  }

  void load_map_roles() {
    roles.forEach((role) {
      this._roles_map[role] = true;
    });
  }

  Map to_map() {
    return {
      'id': this.id,
      'name': this.name,
      'city': this.city,
      'state': this.state,
      'credit_note': this.creditNote,
      'credit_limit': this.creditLimit,
      'required_pod': this.requiredPod,
      'currency': this.currency,
      'rating': this.rating,
      'note': this.note,
      'tax_id': this.taxId,
      'invoice_method': this.invoiceMethod,
      'terms': this.terms,
      'roles': this.roles_to_list(),
      'import_customs_broker_id': this.importCustomsBrokerId,
      'export_customs_broker_id': this.exportCustomsBrokerId,
      'currency_risk_factor': this.currencyRiskFactor,
      'sales_rep_id': this.salesRepId,
      'territory_id': this.territoryId,
      'locations_attributes': locations_to_map(),
      'contacts': contacts_to_map(),
    };
  }
}
