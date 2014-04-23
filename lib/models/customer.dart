part of transnode;

class Customer extends Partner {

  @NgTwoWay("errors")
  Map<String, List<String>> errors;

  Customer() {
    this.balance = 0.0;
    this.locations = [new Location()];
    this.contacts = [new Contact()];
    this._validator = new CustomerValidator(this);
  }

  Location new_empty_location() {
    Location location = new Location();
    this.locations.add(location);
    return location;
  }

  @override
  void loadWithJson(Map<String, dynamic> map) {
    super.loadWithJson(map);
    this.locations = [];
    this.contacts = [];
    map['locations_attributes'].forEach((attr){
          Location l = new Location();
          l.loadWithJson(attr);
          this.locations.add(l);
        });
    map['contacts_attributes'].forEach((attr){
          Contact c = new Contact();
          c.loadWithJson(attr);
          this.contacts.add(c);
        });    
  }
  
  void delete_location(Location location) {
    locations.remove(location);
  }

  bool full_valid() {
    // i use  'result = validation && result, for forced the validations
    bool result = _validator.run_validations();
    this.locations.forEach((location) => result = location.is_valid() && result);
    this.contacts.forEach((contact) => result = contact.is_valid() && result);
    return result;
  }

  bool has_many_locations() {
    return locations.length > 1;
  }

  bool has_many_contacts() {
    return contacts.length > 1;
  }

  Map to_map() {
    return {
      'id': this.id,
      'name': this.name,
      'city': this.city,
      'state': this.state,
      'zip': this.zip,
      'locations_attributes': locations_to_map(),
      'contacts_attributes': contacts_to_map(),
    };
  }
}
