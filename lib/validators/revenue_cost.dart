part of transnode;
class RevenueCostValidator extends Validator {
  RevenueCost _revenueCost;

  RevenueCostValidator(this._revenueCost) {
    this.clean_errors();
  }

  bool run_validations() {
    this.clean_errors();
     required_field(_revenueCost.account_code, "account_code");
     required_field(_revenueCost.amount, "amount");
     required_field(_revenueCost.amount_ca, "amount_ca");
     required_field(_revenueCost.vendor, "vendor");
     required_field(_revenueCost.description, "description");
     required_field(_revenueCost.e_or_p, "e_or_p");
     required_field(_revenueCost.billTo, "billTo");
     required_field(_revenueCost.invoice, "invoice");
     required_field(_revenueCost.status, "status");
    return this.valid();
  }

}