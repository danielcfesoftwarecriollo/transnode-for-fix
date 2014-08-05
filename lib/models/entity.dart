part of transnode;

class Entity extends RecordModel {
  String name;
  String creditNote;
  double creditLimit;
  double balance;
  bool requiredPod;
  String currency;
  int _rating;
  String note;
  String taxId;
  String invoiceMethod;
  String terms;
  String importCustomsBrokerId;
  String exportCustomsBrokerId;
  String currencyRiskFactor;
  String salesRepId;
  String territoryId;
  String sourceId;
  int billToId;
  List roles;
  Map _roles_map;
  List<Location> locations;

  int get rating => _rating;

  void set rating(value) {
    if (value == null) {
      _rating = null;
    } else {
      _rating = value.toInt();
    }
  }

  Location new_empty_location() {
    Location location = new Location();
    this.rating = 0;
    this.locations.add(location);
    return location;
  }
  
  Location mainLocation(){
    Location location = this.locations.firstWhere((e)=> e.roles.contains('main') );
    return location;
  }
  
  void delete_location(Location location) {
    locations.remove(location);
  }


  bool count_locations() {
    return locations.length > 1;
  }


  List<Map> locations_to_map() {
    List<Map> locations_map = [];
    this.locations.forEach((location) => locations_map.add(location.to_map()));
    return locations_map;
  }



  List roles_to_list() {
    List roles_return = [];
    _roles_map.forEach((role, has_role) {
      if (has_role) roles_return.add(role);
    });
    return roles_return;
  }

  void loadWithJson(Map<String, dynamic> map) {
    super.loadWithJson(map);
    load_map_roles();
  }

  void load_map_roles() {
    roles.forEach((role) {
      this._roles_map[role] = true;
    });
  }

  Map to_map() {
    return {
      'id': this.id,
      'name': this.name,
      'credit_note': this.creditNote,
      'credit_limit': this.creditLimit,
      'required_pod': this.requiredPod,
      'bill_to_id': this.billToId,
      'currency': this.currency,
      'rating': this.rating,
      'note': this.note,
      'tax_id': this.taxId,
      'invoice_method': this.invoiceMethod,
      'terms': this.terms,
      'source_id': this.sourceId,
      'roles': this.roles_to_list(),
      'import_customs_broker_id': this.importCustomsBrokerId,
      'export_customs_broker_id': this.exportCustomsBrokerId,
      'currency_risk_factor': this.currencyRiskFactor,
      'sales_rep_id': this.salesRepId,
      'territory_id': this.territoryId,
      'locations_attributes': locations_to_map()
    };
  }
}
