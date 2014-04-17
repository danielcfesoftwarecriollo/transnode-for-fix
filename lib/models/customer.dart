part of transnode;

class Customer extends RecordModel{
  int id;
  String name;
  String city;
  String state;
  String zip;
  String creditNote;
  double creditLimit;
  double balance;
  bool requiredPOD;
  String currency;
  int rating;
  String note;
  String taxId;
  String invoice;
  String terms;
  String importCustomsBroker;
  String exportCustomsBroker;
  String currencyRiskFactor;
  String salesRep;
  String territory;
  
  List<Contact> contacts;
  List<Location> locations;

  @NgTwoWay("errors")
  List errors;

  bool has_errors;

  Customer() {
    this.balance = 0.0;
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
      'id': this.id,
      'name': this.name,
      'city': this.city,
      'state': this.state,
      'zip': this.zip,
      'locations_attributes': locations_to_map()
    };
  }
}
