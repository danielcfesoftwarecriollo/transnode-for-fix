part of transnode;
class ShipmentValidator extends Validator {
  Shipment _shipment;

  ShipmentValidator(this._shipment) {
    this.clean_errors();
  }

  bool run_validations() {
    this.clean_errors();
    run_validations_step1();
    run_validations_step2();
    return this.valid();
  }

  bool run_validations_step1() {
    this.clean_errors();
      required_field(_shipment.customer, "customer");
      required_field(_shipment.customBroker, "customBroker");
      required_field(_shipment.billto, "billto");
      list_notEmpty(_shipment.shippers,'shippers' );
      list_notEmpty(_shipment.consignees,'consignees' );
    return this.valid();
  }
  
  bool run_validations_step2() {
    this.clean_errors();
    list_notEmpty(_shipment.carriers,'carriers');
    list_notEmpty(_shipment.revCosts,'revenue_and_costs');
    return this.valid();
  }
}