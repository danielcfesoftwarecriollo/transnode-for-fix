part of transnode;
class CarrierValidator extends Validator {
  Carrier _carrier;

  CarrierValidator(this._carrier) {
    this.clean_errors();
  }

  bool run_validations() {
    this.clean_errors();
    required_string(_carrier.name, "name");
    required_string(_carrier.note, "note");    
    return this.valid();
  }

}
