part of transnode;

class ShipmentOrder {
  Customer bill_to;
  Customer customer;
  Shipper  shipper;

  String file_created;
  String credit_check;

  ShipmentOrder() {
    this.bill_to  = new Customer();
    this.customer = new Customer();
    this.shipper  = new Shipper();
  }
}
