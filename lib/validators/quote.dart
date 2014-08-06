part of transnode;
class QuoteValidator extends Validator {
  Quote _quote;

  QuoteValidator(this._quote) {
    this.clean_errors();
  }

  bool run_validations() {
    this.clean_errors();
//    required_field(_quote.fromCity, "fromCity");

    return this.valid();
  }

}
