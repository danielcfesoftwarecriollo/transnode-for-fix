part of transnode;

class Carrier extends Entity {

  @NgTwoWay("errors")
  Map<String, List<String>> errors;

  Carrier() {
    this.roles = ["carrier"];
    this._roles_map = {
      "carrier": true
    };
    Location first_location = new Location();
    first_location.set_rol_main();
    this.locations = [first_location];
    this._validator = new CarrierValidator(this);
  }

  Location new_empty_location() {
    Location location = new Location();
    this.locations.add(location);
    return location;
  }

  Location new_empty_lane() {
    Lane lane = new Lane();
    this.locations.add(lane);
    return lane;
  }
  
  @override
  void loadWithJson(Map<String, dynamic> map) {
    super.loadWithJson(map);
    this.locations = [];
    if (map.containsKey("locations_attributes")) {
      map['locations_attributes'].forEach((attr) {
        Location l = new Location();
        l.loadWithJson(attr);
        this.locations.add(l);
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

  bool valid() {
    bool result = _validator.run_validations();
    this.locations.forEach((location) => result = location.full_valid() && result);
    return result;
  }


  bool has_many_locations() {
    return locations.length > 1 && _exists_at_least_more_than_two_locations_available();
  }

  bool _exists_at_least_more_than_two_locations_available() {
    return total_locations_delete_pending() < locations.length - 1;
  }

  int total_locations_delete_pending() {
    return locations.fold(0, (int total, Location location) =>
        (location.pending_to_delete() ? total + 1 : total));
  }

}
