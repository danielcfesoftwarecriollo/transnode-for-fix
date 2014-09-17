part of transnode;

class ExchangeRate extends RecordModel{

  String createdAt;
  String updatedAt;
  String currency;
  double value;

  ExchangeRate(){
    this._validator = new ExchangeRateValidator(this);
  }
  
  Map to_map() {
    print('lines');
    return {
      'id'    : id,
      'currency' : currency,
      'value' : value
    };
  }
  
}
