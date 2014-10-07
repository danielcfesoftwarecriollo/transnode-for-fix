part of transnode;
class CostValidator extends Validator {
  Cost _cost;

  CostValidator(this._cost) {
    this.clean_errors();
  }

  bool run_validations() {
    this.clean_errors();
     required_field(_cost.accountCode, "accountCode");
     required_field(_cost.amount, "amount");
     format_double( double.parse(_cost.amount), "amount");
     required_field(_cost.amountCa, "amountCa");
     required_field(_cost.vendor, "vendor");
     required_field(_cost.currency, "currency");
    return this.valid();
  }

}