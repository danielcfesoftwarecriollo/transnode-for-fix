part of transnode;
class ShipmentShipperValidator extends Validator {
  Shipper _shipmentShipper;

  ShipmentShipperValidator(this._shipmentShipper) {
    this.clean_errors();
  }

  bool run_validations() {
    this.clean_errors();
//    required_field(_shipmentShipper.instructions, "instructions");
    required_field(_shipmentShipper.dateReady, "dateReady");
//    required_field(_shipmentShipper.openFrom, "openFrom");
//    required_field(_shipmentShipper.openTo, "dateReady");
//    required_field(_shipmentShipper.dateAppointment, "dateAppointment");
//    required_field(_shipmentShipper.appointmentHour, "appointmentHour");
//    required_field(_shipmentShipper.specialHandling, "specialHandling");
    required_field(_shipmentShipper.locationCustomer,'shipper' );
    list_notEmpty(_shipmentShipper.lines,'lines' );
    return this.valid();
  }
}
