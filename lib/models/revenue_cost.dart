part of transnode;

class RevenueCost extends RecordModelNested{

  Revenue revenue;
  Cost cost;
  String profit;
  
  RevenueCost(){
    revenue = new Revenue();
    cost = new Cost();
//    this._validator = new RevenueCostValidator(this);
  }
  
  @override
  void loadWithJson(Map<String, dynamic> map) {
     super.loadWithJson(map);
     this._loadListObj(map);
  }

  _loadListObj(map){
    loadRevenue(map);
    loadCost(map);
  }
  
  loadRevenue(Map vendorMap ){
    if(vendorMap['revenue'] != null){
      Revenue r = new Revenue();
      r.loadWithJson(vendorMap['revenue']);  
      this.revenue = r;
    }
    vendorMap.remove('revenue');
  }
  
  loadCost(Map shipmentMap ){
    if(shipmentMap['cost'] != null){
      Cost c = new Cost();
      c.loadWithJson(shipmentMap['cost']);  
      this.cost = c;
    }
    shipmentMap.remove('cost');
  }
  
  void calculateProfit(){
    var aux = this.revenue.amountCa - this.cost.amountCa;
    this.profit = aux.toStringAsFixed(2);
  }

  Map to_map() {
    print('to_map revenue and Costs');
    return {
      'id' : id,
      'revenue' : this.revenue.to_map(),
      'cost' : this.cost.to_map(),
      '_destroy': _destroy
    };
  }

}
