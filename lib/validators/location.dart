part of transnode;
class LocationValidator extends Validator {
  Location _location;

  LocationValidator(this._location);

  bool run_validations() {
    errors = new Map<String, List<String>>();
    required_string(_location.address_1, "address");
    required_string(_location.state, "state");
    required_string(_location.zip, "zip");
    required_string(_location.phone, "phone");
    required_string(_location.status, "status");
    return this.valid();
  }
}
