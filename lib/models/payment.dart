part of transnode;

class Payment extends RecordModelNested{
  DateTime    payDate;
  String  currency;
  double  amount;
  int invoiceId;
  int customerId;
  String payType;
  String checkNumber;
  DateTime   checkDate;
  double localAmount;
  String status;
  List<PaymentInvoice> paymentInvoices;
  Location billTo;
  double balancePay;
  
  Payment(){
    this._validator = new PaymentValidator(this);
    this.payDate = DateHelper.currentDate();
    this.checkDate = DateHelper.currentDate();
    this.balancePay = 0.0;
    status = 'new_p';
  }
  
  bool full_validator(){
    bool result = this.is_valid();
    this.paymentInvoices.forEach((pI) => result = pI.is_valid() && result);
    return result;
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
      'pay_date' : payDate.toIso8601String(),
      'currency' : currency,
      'amount' : amount,
      'pay_type' : payType.toLowerCase(),
      'check_number' : checkNumber,
      'check_date' : checkDate.toIso8601String(),
      'local_amount' : localAmount,
      'status' : status,
      'payment_invoices_attributes' : HelperList.to_map(paymentInvoices),
      'bill_to_id' : this.billTo.id
    };
  }
}
