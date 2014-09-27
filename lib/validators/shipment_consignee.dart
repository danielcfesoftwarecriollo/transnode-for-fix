part of transnode;
class ShipmentConsigneeValidator extends Validator {
  Consignee _shipmentConsignee;

  ShipmentConsigneeValidator(this._shipmentConsignee) {
    this.clean_errors();
  }

  bool run_validations() {
    this.clean_errors();

    return this.valid();
  }

}

