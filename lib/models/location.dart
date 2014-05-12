part of transnode;

class Location extends RecordModelNested {
  int partnerId;
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

  List roles;
  Map<String, bool> _roles_map;

  List freightClass;
  List salesTerritory;

  bool _expanded;

  bool get valid => false;

  Location() {
    this._validator = new LocationValidator(this);
    _expanded = false;
    this._roles_map = {};
  }

  void set_rol_main() {
    this._roles_map['main'] = true;
  }

  bool is_expanded() {
    return is_new() || _expanded;
  }

  void expand() {
    _expanded = !_expanded;
  }

  List roles_to_list() {
    List roles_return = [];
    _roles_map.forEach((role, has_role) {
      if (has_role) {
        roles_return.add(role);
      }
    });
    return roles_return;
  }

  Map to_map() {
    return {
      'id': id,
      'partner_id': partnerId,
      'sales_rep_id': salesRep,
      'name': name,
      'address_1': address1,
      'address_2': address2,
      'country': country,
      'state': state,
      'city': city,
      'zip': zip,
      'on': on,
      'phone': phone,
      'fax': fax,
      'lane_code': laneCode,
      'email': email,
      'roles': roles_to_list(),
      'freight_class': freightClass,
      'sales_territory': salesTerritory,
      'status': status,
      '_destroy': _destroy
    };
  }
}
