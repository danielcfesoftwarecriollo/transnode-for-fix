part of transnode;
class ExchangeRateValidator extends Validator {
  ExchangeRate _exchangeRate;
  ExchangeRateValidator(this._exchangeRate) {
    this.clean_errors();
  }

  bool run_validations() {
    this.clean_errors();
    
    return this.valid();
  }
}
