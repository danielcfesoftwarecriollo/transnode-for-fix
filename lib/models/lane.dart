part of transnode;

class Lane extends RecordModelNested{
  int id;
  City term1;
  City term2;
  int carrierId;
  String serviceNote;
  List <Price> prices;
  bool _expanded;
  
  
  Lane(){
    this._validator = new LaneValidator(this);
  }
  
  bool is_expanded() {
    return is_new() || _expanded;
  }

  void expand() {
    _expanded = !_expanded;
  }
  
  @override
  void loadWithJson(Map<String, dynamic> map) {
    super.loadWithJson(map);
    if (map.containsKey("prices_attributes")) {
      this.prices = [];
      map['prices_attributes'].forEach((attr) {
        Price c = new Price();
        c.loadWithJson(attr);
        this.prices.add(c);
      });
    }
  }
  
  
  void delete_contact(Contact contact) {
    if (contact.is_new()) {
      contacts.remove(contact);
    } else {
      contact.delete();
    }
  }
  
  
  
  
  Map to_map() {
    return {
      'id' : id,
      'term1'  : term1,
      'term2' : term2,
      'service_note' : serviceNote,
      'carrier_id': carrierId
    };
  }
  
  Map to_map_customer(){
    return {
      'id' : id,
      'term1'  : term1,
      'term2' : term2,
      'service_note' : serviceNote,
      'carrier_id': carrierId,
      '_destroy':_destroy
    };
  }
}
