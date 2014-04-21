part of transnode;
class CustomerValidator extends Validator{
  Customer _customer;

  CustomerValidator(this._customer){
    this.clean_errors();
  }

  bool run_validations() {
    errors = new Map<String, List<String>>();
    required_string(_customer.name, "name");
    required_string(_customer.state, "state");
    required_string(_customer.zip, "zip");
    return this.valid();
  }
}
