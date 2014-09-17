part of transnode;

class QuoteCost extends RecordModelNested {

  Quote quote;
  Carrier vendor;
  Lane what;
  String number;
  String currency;
  String priceCAD;
  String createdAt;
  String updatedAt;
  
  QuoteCost() {
    this._validator = new QuoteCostValidator(this);
  }
  
  calculateCAD(){
    return this.number;
  }
  
  @override
  void loadWithJson(Map<String, dynamic> map) {
    loadVendor(map);
    loadLane(map);
    super.loadWithJson(map);
  }
  
  loadVendor(Map customerMap ){
    if(customerMap['vendor'] != null){
      this.vendor = LoadModel.loadCarrier(customerMap['vendor']);
    }
    customerMap.remove('vendor');
  }
  
  loadLane(Map customerMap ){
    if(customerMap['what'] != null){
      this.what = LoadModel.loadLane(customerMap['what']);
    }
    customerMap.remove('what');
  }
  
  Map to_map() {
    print(this);
    return {
      'id': this.id,
      'vendor_id': this.vendor.id,
      'what_id': this.what.id,
      'number':this.number,
      '_destroy':_destroy
    };
  }
  
}
