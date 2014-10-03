part of transnode;

class ExchangeRateFactor extends RecordModel{

  String createdAt;
  String updatedAt;
  String name;
  double value;

  ExchangeRateFactor(){
//    this._validator = new ExchangeRateValidator(this);
  }
  
  Map to_map() {
    print('lines');
    return {
      'id'    : id,
      'name' : name,
      'value' : value
    };
  }
  
}
