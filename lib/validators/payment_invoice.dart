part of transnode;
class PaymentInvoiceValidator extends Validator {
  PaymentInvoice _paymentInvoice;

  PaymentInvoiceValidator(this._paymentInvoice) {
    this.clean_errors();
  }

  bool run_validations() {
    this.clean_errors();    
    if(ParserNumber.toDouble(_paymentInvoice.amount)>0){
      required_field(_paymentInvoice.balanceAfter, "balanceAfter");
      greater_than(_paymentInvoice.balanceAfter,0,"balanceAfter"); 
    }   
    return this.valid();
  }

}
