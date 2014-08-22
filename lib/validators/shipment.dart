part of transnode;
class ShipmentValidator extends Validator {
  Shipment _shipment;

  ShipmentValidator(this._shipment) {
    this.clean_errors();
  }

  bool run_validations() {
    this.clean_errors();
    // required_field(_shipment.speed_rating, "speed_rating");
    // required_field(_shipment.quality_rating, "quality_rating");
    // required_field(_shipment.price_rating, "price_rating");
    // required_field(_shipment.customerId, "customerId");
    // required_field(_shipment.file_created, "file_created");
    // required_field(_shipment.credit_check, "credit_check");
    // required_field(_shipment.customsbrokerId, "customsbroker_id");
    // required_field(_shipment.multipleCarriers, "multiple_carriers");
    return this.valid();
  }

}