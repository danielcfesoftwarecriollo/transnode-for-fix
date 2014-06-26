part of transnode;

class Location extends RecordModelNested {
  int partnerId;
  int salesRep;
  String name;
  String address1;
  String address2;
  var country;
  List  states;
  int stateId;
  int countryId;
  String city;
  String zip;
  String on;
  String phone;
  String fax;
  String laneCode;
  String email;
  String hours;
  String naics;
  String note;

  bool emailOptOut;
  String status;

  List<Contact> contacts;

  
  List roles;
  Map<String, bool> _roles_map;

  List freightClass;
  List salesTerritory;

  bool _expanded;

  bool get valid => false;

  Location() {
    this._validator = new LocationValidator(this);
    this.contacts = [new Contact()];

    _expanded = false;
    this._roles_map = {};
  }

  void set_rol_main() {
    this._roles_map['main'] = true;
  }

  Contact new_empty_contact() {
    Contact contact = new Contact();
    this.contacts.add(contact);
    return contact;
  }
  
  @override
  void loadWithJson(Map<String, dynamic> map) {
    super.loadWithJson(map);
    if (map.containsKey("contacts_attributes")) {
      this.contacts = [];
      map['contacts_attributes'].forEach((attr) {
        Contact c = new Contact();
        c.loadWithJson(attr);
        this.contacts.add(c);
      });
    }
  }
  void delete_contact(Contact contact) {
    if (contact.is_new()) {
      contacts.remove(contact);
    } else {
      contact.delete();
    }
  }

  bool count_contacts() {
    return contacts.length > 1;
  }
  List<Map> contacts_to_map() {
    List<Map> contacts_map = [];
    this.contacts.forEach((contact) => contacts_map.add(contact.to_map_customer(
        )));
    return contacts_map;
  }

  bool is_expanded() {
    return is_new() || _expanded;
  }

  void expand() {
    _expanded = !_expanded;
  }

  List roles_to_list() {
    List roles_return = [];
    _roles_map.forEach((role, has_role) {
      if (has_role) {
        roles_return.add(role);
      }
    });
    return roles_return;
  }

  bool full_valid(){
    bool result = _validator.run_validations();
    this.contacts.forEach((contact) => result = contact.is_valid() && result);
    return result;
  }
  bool has_many_contacts() {
    return contacts.length > 1 &&
        _exists_at_least_more_than_two_contacts_available();
  }

  bool _exists_at_least_more_than_two_contacts_available() {
    return _total_contacts_delete_pending() < contacts.length - 1;
  }

  int _total_contacts_delete_pending() {
    return contacts.fold(0, (int total, Contact contact) =>
        (contact.pending_to_delete() ? total + 1 : total));
  }

  
  Map to_map() {
    return {
      'id': id,
      'partner_id': partnerId,
      'sales_rep_id': salesRep,
      'name': name,
      'states': states,
      'address_1': address1,
      'address_2': address2,
      'country_id': countryId,
      'state_id': stateId,
      'city': city,
      'zip': zip,
      'on': on,
      'phone': phone,
      'fax': fax,
      'lane_code': laneCode,
      'email': email,
      'roles': roles_to_list(),
      'freight_class': freightClass,
      'sales_territory': salesTerritory,
      'contacts_attributes': contacts_to_map(),
      'status': status,
      '_destroy': _destroy
    };
  }
}
