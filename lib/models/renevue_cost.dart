part of transnode;

class RevenueCost extends RecordModelNested{

  String accountCode;
  String amount;
  String currency;
  double amountCa; //mount with converted if currency is not CAD
  Carrier vendor;
  String description;
  String eOrP;
  Location billTo;
  String invoice;
// Invoice invoice;
  String status; //change to status int
  String revenueAmountCa;
  String costAmountCa;
  String profit;
  
  String createdAt;
  String updatedAt;
  
  RevenueCost(){
    this._validator = new RevenueCostValidator(this);
  }
  
  @override
  void loadWithJson(Map<String, dynamic> map) {
     super.loadWithJson(map);
     this._loadListObj(map);
  }

  _loadListObj(map){
    loadBillTo(map);
    loadVendor(map);
    calculateProfit();
  }
  
  loadVendor(Map vendorMap ){
    if(vendorMap['vendor'] != null){
      Carrier vendor = new Carrier();
      vendor.loadWithJson(vendorMap['vendor']);  
      this.vendor = vendor;
    }
    vendorMap.remove('vendor');
  }
  
  loadBillTo(Map shipmentMap ){
    if(shipmentMap['bill_to'] != null){
      Location l = new Location();
      l.loadWithJson(shipmentMap['bill_to']);  
      this.billTo = l;
    }
    shipmentMap.remove('bill_to');
  }
  
  void calculateProfit(){
    var aux = double.parse(this.costAmountCa) - double.parse(this.revenueAmountCa);
    this.profit = aux.toStringAsFixed(2);
  }
  
  Map to_map() {
    print('to_map revenue and Costs');
    return {
      'id' : id,
      'account_code' : accountCode,
      'amount' : amount,
      'currency' : currency,
      'amount_ca' : amountCa,
      'revenue_amount_ca' : revenueAmountCa,      
      'cost_amount_ca' : costAmountCa,
      'vendor_id' : vendor.id,
      'description' : description,
      'e_or_p' : eOrP,
      'bill_to_id' : (billTo == null)? null : billTo.id,
      'invoice' : invoice,
      'status' : status,
      '_destroy': _destroy
    };
  }

}
