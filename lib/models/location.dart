part of transnode;

class Location extends RecordModel{
  int id;
  int partner_id;
  int salesRep;
  String name;
  String address_1;
  String address_2;
  String country;
  String state;
  String city;
  String zip;
  String on;
  String phone;
  String fax;
  String laneCode;
  String email;
  String hours;
  bool emailOptOut;
  
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
      'address_1': address_1,
      'address_2': address_2,
      'country': country,
      'state': state,
      'city': city,
      'zip': zip,
      'on': on,
      'phone': phone,
      'fax': fax,
      'laneCode': laneCode,
      'email': email,
      'freightClass': freightClass,
      'salesTerritory': salesTerritory,
      'status': status
    };
  }

}
