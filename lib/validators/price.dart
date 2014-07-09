part of transnode;
class PriceValidator extends Validator {
  Price _price;

  PriceValidator(this._price) {
    this.clean_errors();
  }

  bool run_validations() {
    this.clean_errors();
    required_field(_price.laneId, "laneid");
    required_field(_price.unit, "unit");
    required_field(_price.number, "number");
    required_field(_price.price, "price");
    return this.valid();
  }

  int id;
  int laneId;
  int unit;
  int number;
  double price;  
  
}
