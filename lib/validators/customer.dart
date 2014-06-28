part of transnode;
class CustomerValidator extends Validator {
  Customer _customer;

  CustomerValidator(this._customer) {
    this.clean_errors();
  }

  bool run_validations_step1() {
    this.clean_errors();
    required_string(_customer.name, "name");
    return this.valid();
  }
  
  bool run_validations_step2() {
    this.clean_errors();
    format_double(_customer.creditLimit, "creditLimit");
    range_int(_customer.rating, "rating",min:1,max:5, required: true);
    return this.valid();
  }
}
