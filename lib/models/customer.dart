part of transnode;

class Customer {
  String code;
  String name;
  String city;
  String state;
  String zip;
  String creditNote;
  double creditLimit;
  String balance;
  bool requiredPOD;
  String currency;
  int rating;
  String note;

  List<Contact> contacts;
  List<Location> locations;

  @NgTwoWay("errors")
  List errors;

  bool has_errors;

  Customer() {
    this.contacts = [new Contact()];
    this.locations = [new Location()];
    this.errors = [];
  }

  Contact new_empty_contact() {
    Contact contact = new Contact();
    this.contacts.add(contact);
    return contact;
  }
  void delete_contact(Contact contact) {
    contacts.remove(contact);
  }

  bool has_many_contacts() {
    return contacts.length > 1;
  }

  Location new_empty_location() {
    Location location = new Location();
    this.locations.add(location);
    return location;
  }
  void delete_location(Location location) {
    locations.remove(location);
  }

  bool has_many_locations() {
    return locations.length > 1;
  }

  List<Map> contacts_to_map() {
    List<Map> contacts_map = [];
    this.contacts.forEach((contact) => contacts_map.add(contact.to_map()));

    return contacts_map;
  }
  List<Map> locations_to_map() {
    List<Map> locations_map = [];
    this.locations.forEach((location) => locations_map.add(location.to_map()));
    return locations_map;
  }

  void set_errors(Map errors_map) {
    this.has_errors = true;
    this.errors = errors_map['customers'];
  }

  void clean_errors() {
    this.errors = [];
    this.has_errors = false;
  }

  Map to_map() {
    return {
      'code': this.code,
      'name': this.name,
      'city': this.city,
      'state': this.state,
      'zip': this.zip,
      'contacts': contacts_to_map()
    };
  }
}
