part of transnode;

class Partner extends RecordModel {

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

  List<Location> locations;
  List<Contact> contacts;

  Location new_empty_location() {
    Location location = new Location();
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
    this.contacts.forEach((contact) => contacts_map.add(contact.to_map()));
    return contacts_map;
  }

  Map to_map() {
    return {
      'id': this.id,
      'name': this.name,
      'city': this.city,
      'state': this.state,
      'zip': this.zip,
      'locations_attributes': locations_to_map(),
      'contacts': contacts_to_map(),
    };
  }
}
