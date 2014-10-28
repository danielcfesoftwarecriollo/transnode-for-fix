part of transnode;
class ReviewInvoiceApValidator extends Validator {
  InvoiceAP _invoice;

  ReviewInvoiceApValidator(this._invoice) {
    this.clean_errors();
  }

  bool run_validations() {
    this.clean_errors();
    required_field(_invoice.acepted, "status_review");
    return this.valid();
  } 

}
