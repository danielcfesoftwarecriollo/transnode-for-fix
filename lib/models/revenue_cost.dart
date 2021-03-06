part of transnode;

class RevenueCost extends RecordModelNested{

  Revenue revenue;
  Cost cost;
  String profit;
  
  RevenueCost(){
    revenue = new Revenue();
    cost = new Cost();
    this._validator = new RevenueCostValidator(this);
  }
  
  @override
  void loadWithJson(Map<String, dynamic> map) {
     super.loadWithJson(map);
     this._loadListObj(map);
  }

  _loadListObj(map){
    loadRevenue(map);
    loadCost(map);
    calculateProfit();
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
  
  bool full_valid(){
    bool result = _validator.run_validations();
    result = this.revenue.is_valid() && result;
    result = this.cost.is_valid() && result;
    return result;
  } 
  
  void calculateProfit(){
    double aux;
    if(this.revenue.amountCa != null && this.cost.amountCa != null){
      aux = ParserNumber.toDouble(this.revenue.amountCa) - ParserNumber.toDouble(this.cost.amountCa);
      this.profit = aux.toStringAsFixed(2);
    }else{
      this.profit = '0.0';
    }
  }

  Map to_map() {
    print('to_map revenue and Costs');
    return {
      'id' : id,
      'revenue_attributes' : this.revenue.to_map(),
      'cost_attributes' : this.cost.to_map(),
      '_destroy': _destroy
    };
  }

}
