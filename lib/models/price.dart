part of transnode;

class Price extends RecordModelNested{
  int id;
  id laneId;
  int unit;
  int number;
  double price;

  Price(){
    this._validator = new PriceValidator(this);
  }
  
  Map to_map() {
    return {
      'id' : id,
      'lane_id'  : laneId,
      'unit' : unit,
      'number' : number,
      'price': price
    };
  }
  
  Map to_map_customer(){
    return {
      'id' : id,
      'lane_id'  : laneId,
      'unit' : unit,
      'number' : number,
      'price': price,
      '_destroy':_destroy
    };
  }
}
