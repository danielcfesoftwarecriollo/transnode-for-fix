part of transnode;

class Payment extends RecordModelNested{
  Date    payDate;
  String  currency;
  double  amount;
  int invoiceId;
  int customerId;
  int payType;
  String checkNumber;
  Date    checkDate;
  double localAmount;
  int status;
  List<PaymentInvoice> paymentInvoices;
  Location billTo;
  
  Payment(){
//    this._validator = new PaymentValidator(this);
  }
  
  @override
  void loadWithJson(Map<String, dynamic> map) {
   this.billTo = loadLocationByMap(map,'bill_to');
   loadPaymentInvoicesByMap(map, 'payment_invoice_attributes');
   this.payDate = loadDate(map, 'pay_date');
   this.checkDate = loadDate(map, 'check_date');
   super.loadWithJson(map);
  }
  
  void loadPaymentInvoicesByMap(map,target){
    this.paymentInvoices = [];
    if(map[target] != null){
      map[target].forEach((i){
        this.paymentInvoices.add(LoadModel.loadPaymentInvoice(i));
      });
      map.remove(target);
    }
  }
    
  static loadLocationByMap(map,target){
    var aux;
    if(map[target] != null){
      aux = LoadModel.loadLocation(map[target]);
      map.remove(target);
    }
    return aux;
  }
  
  loadDate(Map map, key){
    DateTime aux;
    if(map.containsKey(key)){
      aux = LoadModel.loadDateTime(map[key]);
      map.remove(key);      
    }
    return aux;
  }
  
  Map to_map() {
    return {
      'id' : id,
      'pay_date' : payDate,
      'currency' : currency,
      'amount' : amount,
      'invoices_attributes' : HelperList.to_map(paymentInvoices),
      'invoice_id' : invoiceId,
      'customer_id' : customerId,
      'pay_type' : payType,
      'check_number' : checkNumber,
      'check_date' : checkDate,
      'local_amount' : localAmount,
      'status' : status,
//      'customer' : customer,
    };
  }
}
