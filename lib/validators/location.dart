part of transnode;
class LocationValidator extends Validator {
  Location _location;

  LocationValidator(this._location){
    this.clean_errors();
  }

  bool run_validations() {
    this.clean_errors();
    email_format(_location.email,'email');
    required_string(_location.address_1, "address_1");
    required_string(_location.country, "country");
    required_string(_location.city, "city");
    required_string(_location.zip, "zip");
    required_string(_location.phone, "phone");
    return this.valid();
  }
}
