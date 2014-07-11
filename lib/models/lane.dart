part of transnode;

class Lane extends RecordModelNested{
  int id;
  int term1;
  int term2;
  int carrierId;
  String serviceNote;
  List <Price> prices;
  bool _expanded;
  
  
  Lane(){
    prices = [];
    this._validator = new LaneValidator(this);
  }
  
  bool full_valid(){
    bool result = _validator.run_validations();
    this.prices.forEach((price) => result = price.is_valid() && result);
    return result;
  }  
  
  bool is_expanded() {
    return is_new() || _expanded;
  }

  void expand() {
    _expanded = !_expanded;
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
