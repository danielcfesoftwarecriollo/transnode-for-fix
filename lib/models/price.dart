part of transnode;

class Price extends RecordModelNested{

  int unit;
  int number;
  double price;
  bool _expanded;

  Price(){
    this._validator = new PriceValidator(this);
    _expanded = false;
  }
  
  Map to_map() {
    return {
      'id' : id,
      'unit' : unit,
      'number' : number,
      'price': price,
      '_destroy':_destroy
    };
  }
  
  Map to_map_customer(){
    return {
      'id' : id,
      'unit' : unit,
      'number' : number,
      'price': price,
      '_destroy':_destroy
    };
  }
}
