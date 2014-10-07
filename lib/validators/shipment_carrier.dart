part of transnode;
class ShipmentCarrierValidator extends Validator {
  ShipmentCarrier _shipmentCarrier;

  ShipmentCarrierValidator(this._shipmentCarrier) {
    this.clean_errors();
  }

  bool run_validations() {
    this.clean_errors();
//    required_field(_shipmentCarrier.equipment, "equipment");
//    required_field(_shipmentCarrier.service, "service");
//    required_field(_shipmentCarrier.booked, "booked");
//    required_field(_shipmentCarrier.insureAmt, "insureAmt");
//    required_field(_shipmentCarrier.other, "other");
    required_field(_shipmentCarrier.carrier, "carrier");
    return this.valid();
  }

}
