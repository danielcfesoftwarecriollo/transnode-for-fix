part of transnode;
class RevenueCostValidator extends Validator {
  RevenueCost _revenueCost;

  RevenueCostValidator(this._revenueCost) {
    this.clean_errors();
  }

  bool run_validations() {
    this.clean_errors();
     required_field(_revenueCost.revenue, "revenue");
     required_field(_revenueCost.cost, "cost");
     required_field(_revenueCost.profit, "profit");
    return this.valid();
  }

}