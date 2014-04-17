part of transnode;

class Location extends RecordModel{
  int id;
  int partner_id;
  int salesRep;
  String name;
  String address;
  String country;
  String state;
  String city;
  String zip;
  String on;
  String phone;
  String fax;
  String laneCodel;
  String email;
  String hours;
  List freightClass;
  List salesTerritory;
  List status;

  bool get valid => false;

    
  Map to_map() {
    return {
      'id': id,
      'partner_id': partner_id,
      'salesRep': salesRep,
      'name': name,
      'address': address,
      'country': country,
      'state': state,
      'city': city,
      'zip': zip,
      'on': on,
      'phone': phone,
      'fax': fax,
      'laneCodel': laneCodel,
      'email': email,
      'freightClass': freightClass,
      'salesTerritory': salesTerritory,
      'status': status
    };
  }

}
