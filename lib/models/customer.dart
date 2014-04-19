part of transnode;

class Customer extends Partner{

  @NgTwoWay("errors")
  Map<String,List<String>> errors;

  Customer() {
    this.balance = 0.0;
    this.locations = [new Location()];
  }

  Location new_empty_location() {
    Location location = new Location();
    this.locations.add(location);
    return location;
  }
  void delete_location(Location location) {
    locations.remove(location);
  }

  List<Map> locations_to_map() {
    List<Map> locations_map = [];
    this.locations.forEach((location) => locations_map.add(location.to_map()));
    return locations_map;
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
