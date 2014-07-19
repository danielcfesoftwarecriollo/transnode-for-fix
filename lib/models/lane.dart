part of transnode;

class Lane extends RecordModelNested{
  int id;
  int term1Id;
  int term2Id;
  String serviceNote;
  List <Price> prices;
  bool _expanded;
  City  term1;
  City  term2;
  
  Lane(){
    prices = [];
    _expanded = false;
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
      'term1_id' : term1Id,
      'term2_id' : term2Id,
      'service_note' : serviceNote,
      '_destroy':_destroy
    };
  }
  
  Map to_map_carrier(){
    return {
      'id' : id,
      'term1_id'  : term1.id,
      'term2_id' : term2Id,
      'service_note' : serviceNote,
      '_destroy':_destroy
    };
  }
}
