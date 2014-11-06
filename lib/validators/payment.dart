part of transnode;
class PaymentValidator extends Validator {
  Payment _payment;

  PaymentValidator(this._payment) {
    this.clean_errors();
  }

  bool run_validations() {
    this.clean_errors();
    required_field(_payment.payDate, "payDate");
    required_field(_payment.currency, "currency");
    required_field(_payment.amount, "amount");
    this.list_notEmpty(_payment.paymentInvoices, "paymentInvoices");
    required_field(_payment.billTo, "billTo");
    required_field(_payment.payType, "payType");
    required_field(_payment.checkNumber, "checkNumber");
    required_field(_payment.checkDate, "checkDate");
    required_field(_payment.localAmount, "localAmount");
    required_field(_payment.status, "status");
    greater_than(_payment.amount,_payment.balancePay,"balancePay");
    
    return this.valid();
  }

}
