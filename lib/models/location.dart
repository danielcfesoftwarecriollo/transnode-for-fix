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
  String status;
  
  Map<String,bool> roles;
  List freightClass;
  List salesTerritory;
  List<Contact> contacts;
  
  bool get valid => false;
  
  Location() {
    this._validator = new LocationValidator(this);
    this.roles = {
      'shipper':false,
      'billTo':false,
      'cons':false,
      'main':false
    };
    
  }
  
  List roles_keys(){
    return ['shipper', 'billTo', 'cons', 'main'];
  }
  
  
  Contact new_empty_contact() {
    Contact contact = new Contact();
    this.contacts.add(contact);
    return contact;
  }
  void delete_contact(Contact contact) {
    contacts.remove(contact);
  }
  
  List<Map> contacts_to_map() {
    List<Map> contacts_map = [];
    //this.contacts.forEach((contact) => contacts_map.add(contact.to_map()));
    return contacts_map;
  }
  
  bool has_many_contacts() {
    return contacts.length > 1;
  }

  Map to_map() {
    return {
      'id': id,
      'partner_id': partner_id,
      'sales_rep_id': salesRep,
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
      'lane_code': laneCode,
      'email': email,
      'freight_class': freightClass,
      'sales_territory': salesTerritory,
      'status': status,
      'roles': roles,
      "contacts_attributes" : contacts_to_map()
    };
  }

}
