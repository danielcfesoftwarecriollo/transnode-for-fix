part of transnode;
class CustomerValidator extends Validator{
  Customer _customer;
  Map<String, List<String>> errors;

  CustomerValidator(this._customer);

  bool run_validations() {
    errors = new Map<String, List<String>>();
    required_string(_customer.name, "name");
    required_string(_customer.state, "state");
    required_string(_customer.zip, "zip");
    return this.valid();
  }
}
