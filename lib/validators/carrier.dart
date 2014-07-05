part of transnode;
class CarrierValidator extends Validator {
  Carrier _customer;

  CarrierValidator(this._carrier) {
    this.clean_errors();
  }

  bool run_validations() {
    this.clean_errors();
    required_string(_carrier.name, "name");
    return this.valid();
  }

}
