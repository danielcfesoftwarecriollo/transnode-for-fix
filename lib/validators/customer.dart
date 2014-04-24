part of transnode;
class CustomerValidator extends Validator{
  Customer _customer;

  CustomerValidator(this._customer){
    this.clean_errors();
  }

  bool run_validations() {
    this.clean_errors();
    required_string(_customer.name, "name");
    format_zip(_customer.zip, "zip");
    return this.valid();
  }
}
