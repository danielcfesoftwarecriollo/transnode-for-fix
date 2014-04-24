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
    if (map.containsKey("locations_attributes")) {
      map['locations_attributes'].forEach((attr) {
        Location l = new Location();
        l.loadWithJson(attr);
        this.locations.add(l);
      });
    }
    if (map.containsKey("contacts_attributes")) {
      map['contacts_attributes'].forEach((attr) {
        Contact c = new Contact();
        c.loadWithJson(attr);
        this.contacts.add(c);
      });

    }

  }

  void delete_location(Location location) {
    if (location.is_new()) {
      locations.remove(location);
    } else {
      location.delete();
    }
  }
  void delete_contact(Contact contact) {
    if (contact.is_new()) {
      contacts.remove(contact);
    } else {
      contact.delete();
    }
  }

  bool full_valid() {
    // i use  'result = validation && result, for forced the validations
    bool result = _validator.run_validations();
    this.locations.forEach((location) => result = location.is_valid() && result
        );
    this.contacts.forEach((contact) => result = contact.is_valid() && result);
    return result;
  }

  bool has_many_locations() {
    return locations.length > 1 &&
        _exists_at_least_more_than_two_locations_available();
  }

  bool _exists_at_least_more_than_two_locations_available() {
    return total_locations_delete_pending() < locations.length - 1;
  }

  int total_locations_delete_pending() {
    return locations.fold(0, (int total, Location location) =>
        (location.pending_to_delete() ? total + 1 : total));
  }

  bool has_many_contacts() {
    return contacts.length > 1 &&
        _exists_at_least_more_than_two_contacts_available();
  }

  bool _exists_at_least_more_than_two_contacts_available() {
    return total_contacts_delete_pending() < contacts.length - 1;
  }

  int total_contacts_delete_pending() {
    return contacts.fold(0, (int total, Contact contact) =>
        (contact.pending_to_delete() ? total + 1 : total));
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
