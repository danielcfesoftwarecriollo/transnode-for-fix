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
    required_field(_payment.invoice, "invoice");
    required_field(_payment.customer, "customer");
    required_field(_payment.payType, "payType");
    required_field(_payment.checkNumber, "checkNumber");
    required_field(_payment.checkDate, "checkDate");
    required_field(_payment.localAmount, "localAmount");
    required_field(_payment.status, "status");
    return this.valid();
  }

}
