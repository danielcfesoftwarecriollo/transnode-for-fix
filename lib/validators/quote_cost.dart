part of transnode;
class QuoteCostValidator extends Validator {
  QuoteCost _quoteCost;

  QuoteCostValidator(this._quoteCost) {
    this.clean_errors();
  }

  bool run_validations() {
    this.clean_errors();
//    required_field(_quote.fromCity, "fromCity");

    return this.valid();
  }

}
