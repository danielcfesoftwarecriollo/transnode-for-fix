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
    this.prices.forEach((p){
//      result = p.is_valid() && result;
     });
    return result;
  }  

  void delete_price(Price price) {
    if (price.is_new()) {
      prices.remove(price);
    } else {
      price.delete();
    }
  }
  
  bool is_expanded() {
    return is_new() || _expanded;
  }

  void expand() {
    _expanded = !_expanded;
  }
  
  void loadPrices( Map map){
    this.prices = [];
    map['prices_attributes'].forEach((attr){
      Price p = new Price();
      p.loadWithJson(attr);
      this.prices.add(p);
    });
  }

  List<Map> prices_to_map() {
    List<Map> prices_map = [];
    this.prices.forEach((p){ 
      prices_map.add(p.to_map());
    });
    return prices_map;
  }
  
  Map to_map() {
    print('to_map lane');
    return {
      'id' : id,
      'term1_id' : term1.id,
      'term2_id' : term2.id,
      'service_note' : serviceNote,
      'prices_attributes' : prices_to_map(),
      '_destroy':_destroy
    };
  }

}
