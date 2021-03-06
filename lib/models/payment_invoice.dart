part of transnode;

class PaymentInvoice extends RecordModelNested{
  Invoice invoice;
  Payment payment;
  double amount;
  double balanceAfter;
  double localAmount;

  PaymentInvoice(){
    this._validator = new PaymentInvoiceValidator(this);
    this.invoice = new Invoice();
    this.payment = new Payment();
    this.amount  = 0.0;
    this.localAmount  = 0.0;
  }

  @override
  void loadWithJson(Map<String, dynamic> map) {
   this.invoice = loadInvoiceByMap(map,'invoice');
   this.payment = loadPaymentByMap(map,'payment');
   super.loadWithJson(map);
  }
  
  checkBalanceAfter(){
    balanceAfter = (ParserNumber.toDouble(this.invoice.balance) - ParserNumber.toDouble(this.amount));
  }
  
  loadInvoiceByMap(map,target){
    var aux = null;
    if(map[target] != null){
      aux = LoadModel.loadInvoice(map[target]);
      map.remove(target);
    }
    return aux;
  }
  
  loadPaymentByMap(map,target){
    var aux = null;
    if(map[target] != null){
      aux = LoadModel.loadPayment(map[target]);
      map.remove(target);
    }
    return aux;
  }

  Map to_map() {
    return {
      'id' : id,
      'invoice_id' : invoice.id,
      'amount'     : this.localAmount
    };
  }

}
