part of transnode;

class Carrier extends Entity {

  @NgTwoWay("errors")
  Map<String, List<String>> errors;
  List<Lane> lanes;
  String note;
  
  Carrier() {
    this.roles = ["carrier"];
    this.lanes = [];
    this._roles_map = {
      "carrier": true
    };
    Location first_location = new Location();
    first_location.set_rol_main();
    this.locations = [first_location];
    this._validator = new CarrierValidator(this);
    
    Lane first_lane = new Lane();
    this.lanes = [first_lane];    
    
  }

  Location new_empty_location() {
    Location location = new Location();
    this.locations.add(location);
    return location;
  }

  Lane new_empty_lane() {
    Lane lane = new Lane();
    this.lanes.add(lane);
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

    this.lanes = [];
    if (map.containsKey("lanes_attributes")) {
      map['lanes_attributes'].forEach((attr) {
        Lane l = new Lane();
        City c = new City();
        City c2 = new City(); 
        c.loadWithJson(attr['term1']);
        c2.loadWithJson(attr['term2']);
        attr.remove('term1');
        attr.remove('term2');
         l.term1 = c;
         l.term2 = c2;
         l.loadWithJson(attr);
         l.loadPrices(attr);
         this.lanes.add(l);
      });
    }

  }
  
//  void loadCity(Lane l, Map attr){
//    City c = new City();
//    c.loadWithJson(attr['term1']);
//    attr.remove('term1');
//    l
//  }

  void delete_location(Location location) {
    if (location.is_new()) {
      locations.remove(location);
    } else {
      location.delete();
    }
  }

  bool full_validation() {
    bool result = _validator.run_validations();
    this.locations.forEach((location) => result = location.full_valid() && result);
    this.lanes.forEach((lane){ 
      result = lane.full_valid() && result;
    });
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

  bool has_many_lanes() {
    return lanes.length > 1;
  }

  List<Map> lanes_to_map() {
    List<Map> lanes_map = [];
    this.lanes.forEach((lane){ 
      lanes_map.add(lane.to_map());
    });
    return lanes_map;
  }
  
  @override
  Map to_map() {
    print(this);
    return {
      'id': this.id,
      'name': this.name,
      'currency': this.currency,
      'note': this.note,
      'roles': this.roles_to_list(),
      'lanes_attributes': lanes_to_map(),
      'locations_attributes': locations_to_map()
    };
  }

}
