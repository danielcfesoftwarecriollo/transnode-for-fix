part of transnode;
class RevenueValidator extends Validator {
  Revenue _revenue;

  RevenueValidator( this._revenue) {
    this.clean_errors();
  }

  bool run_validations() {
    this.clean_errors();
     required_field(_revenue.accountCode, "accountCode");
     required_field(_revenue.amount, "amount");
     format_double( double.parse(_revenue.amount), "amount");
     required_field(_revenue.amountCa, "amountCa");
     required_field(_revenue.billTo, "billTo");
     required_field(_revenue.currency, "currency");
    return this.valid();
  }

}