part of transnode;
class CityValidator extends Validator {
  City _city;

  CityValidator(this._city) {
    this.clean_errors();
  }

  bool run_validations() {
    this.clean_errors();
    required_string(_city.name, "name");
    required_string(_city.name, "code");
    return this.valid();
  }

}
