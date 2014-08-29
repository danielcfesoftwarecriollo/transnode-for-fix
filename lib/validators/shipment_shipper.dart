part of transnode;
class ShipmentShipperValidator extends Validator {
  ShipmentShipper _shipmentShipper;

  ShipmentShipperValidator(this._shipmentShipper) {
    this.clean_errors();
  }

  bool run_validations() {
    this.clean_errors();

    return this.valid();
  }

}
