part of transnode;

class Location extends RecordModel{

  int partner_id;
  int salesRep;
  String name;
  String address1;
  String address2;
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
  String naics;
  String note;

  bool emailOptOut;
  String status;
  
  Map<String,bool> roles;
  List freightClass;
  List salesTerritory;
  
  bool get valid => false;
  
  Location() {
    this._validator = new LocationValidator(this);    
  }
  
  Map to_map() {
    return {
      'id': id,
      'partner_id': partner_id,
      'sales_rep_id': salesRep,
      'name': name,
      'address1': address1,
      'address2': address2,
      'country': country,
      'state': state,
      'city': city,
      'zip': zip,
      'on': on,
      'phone': phone,
      'fax': fax,
      'lane_code': laneCode,
      'email': email,
      'freight_class': freightClass,
      'sales_territory': salesTerritory,
      'status': status
    };
  }

}
