part of transnode;

class Cost extends RecordModelNested{

  String accountCode;
  String amount;
  String currency;
  double amountCa; //mount with converted if currency is not CAD
  Carrier vendor;
  String description;
  Invoice invoice;
  String status; //change to status int  
  String createdAt;
  String updatedAt;
  
  Cost(){
    status = 'New';
//    this._validator = new RevenueCostValidator(this);
  }
  
  @override
  void loadWithJson(Map<String, dynamic> map) {
     super.loadWithJson(map);
     this._loadListObj(map);
  }

  _loadListObj(map){
    loadVendor(map);
  }
  
  loadVendor(Map vendorMap ){
    if(vendorMap['vendor'] != null){
      Carrier vendor = new Carrier();
      vendor.loadWithJson(vendorMap['vendor']);  
      this.vendor = vendor;
    }
    vendorMap.remove('vendor');
  }

  Map to_map() {
    print('to_map cost');
    return {
      'id' : id,
      'account_code' : accountCode,
      'amount' : amount,
      'currency' : currency,
      'amount_ca' : amountCa,
      'vendor_id' : vendor.id,
      'description' : description,
      'status' : status,
      '_destroy': _destroy
    };
  }

}
