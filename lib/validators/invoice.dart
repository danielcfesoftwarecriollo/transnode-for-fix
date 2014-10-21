part of transnode;
class InvoiceValidator extends Validator {
  Invoice _invoice;

  InvoiceValidator(this._invoice) {
    this.clean_errors();
  }

  bool run_validations() {
    this.clean_errors();
    required_field(_invoice.billTo, "billTo");
    required_field(_invoice.currency, "currency");
    required_field(_invoice.dueDate, "dueDate");
    required_field(_invoice.exportDate, "exportDate");
    this.list_notEmpty(_invoice.selectedItems, "selectedItems");
    return this.valid();
  }
  
  

}
