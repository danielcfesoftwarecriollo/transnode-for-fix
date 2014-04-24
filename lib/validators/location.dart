part of transnode;
class LocationValidator extends Validator {
  Location _location;

  LocationValidator(this._location){
    this.clean_errors();
  }

  bool run_validations() {
    this.clean_errors();
    format_email(_location.email,'email');
    required_string(_location.address1, "address1");
    required_string(_location.country, "country");
    required_string(_location.city, "city");
    format_zip(_location.zip, "zip",required:true);
    format_phone(_location.phone, "phone",required:true);
    return this.valid();
  }
}
