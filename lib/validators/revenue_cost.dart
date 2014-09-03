part of transnode;
class RevenueCostValidator extends Validator {
  RevenueCost _revenueCost;

  RevenueCostValidator(this._revenueCost) {
    this.clean_errors();
  }

  bool run_validations() {
    this.clean_errors();
     required_field(_revenueCost.accountCode, "accountCode");
     required_field(_revenueCost.amount, "amount");
     format_double( double.parse(_revenueCost.amount), "amount");
    //required_field(_revenueCost.amountCa, "amountCa");
     required_field(_revenueCost.vendor, "vendor");
     required_field(_revenueCost.eOrP, "eOrP");
     required_field(_revenueCost.billTo, "billTo");
    //required_field(_revenueCost.invoice, "invoice");
     required_field(_revenueCost.status, "status");
    return this.valid();
  }

}