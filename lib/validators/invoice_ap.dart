part of transnode;
class InvoiceApValidator extends Validator {
  InvoiceAP _invoice;

  InvoiceApValidator(this._invoice) {
    this.clean_errors();
  }

  bool run_validations() {
    this.clean_errors();
    required_field(_invoice.vendor, "vendor");
    required_field(_invoice.currency, "currency");
    required_field(_invoice.dueDate, "dueDate");
    required_field(_invoice.received_date, "received_date");
    this.list_notEmpty(_invoice.selectedItems, "selectedItems");
    return this.valid();
  } 

}
