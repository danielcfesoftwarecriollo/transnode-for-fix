part of transnode;

class Revenue extends RecordModelNested{

  String accountCode;
  double amount;
  String currency;
  double amountCa; //mount with converted if currency is not CAD
  String description;
  Location billTo;
  Invoice invoice;
  String status; //change to status int
  String createdAt;
  String updatedAt;
  
  String billToSelected;
  bool loading; 
  
  Revenue(){
    status = 'new_r';
    amount = 0.0;
    amountCa = 0.0;
    loading = false;
    this._validator = new RevenueValidator(this);
    
  }
  
  @override
  void loadWithJson(Map<String, dynamic> map) {
     super.loadWithJson(map);
     this._loadListObj(map);
  }

  _loadListObj(map){
    loadBillTo(map);
  }
  
  loadBillTo(Map shipmentMap ){
    if(shipmentMap['bill_to'] != null){
      Location l = new Location();
      l.loadWithJson(shipmentMap['bill_to']);  
      this.billTo = l;
      this.billToSelected = l.name;
    }
    shipmentMap.remove('bill_to');
  }

  Map to_map() {
    print('to_map revenue');
    return {
      'id' : id,
      'account_code' : accountCode,
      'amount' : amount,
      'currency' : currency,
      'amount_ca' : amountCa,
      'description' : description,
      'bill_to_id' : (billTo == null)? null : billTo.id,
      'status' : status,
      '_destroy': _destroy
    };
  }

}
