library transnode.model.location;

class Location {
  String name;
  String address;
  String country;
  String city;
  String zip;
  String on;
  Map to_map() {
    return {
      'name'  : name,
      'address' : address,
      'country' : country,
      'city' : city,
      'zip' : zip
    };
  }
}
