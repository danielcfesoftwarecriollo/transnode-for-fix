part of transnode;

class InvoiceItem extends RecordModelNested{

  String status;
  String createdAt;
  String updatedAt;
  double amount;
  double tax;
  Revenue revenue;
  String fileRef;
  String shipmentDateCreated;
  String docs;
  String numPcs;
  String weight;
  String statusShipment;
  Location from;
  Location to;
  
  bool selected;
    
  InvoiceItem(){
    status = 'New';
    selected = false;
//    this._validator = new InvoiceValidator(this);
  }
  
  
  Map to_map() {
    print('to_map invoice_item');
    return {
      'id' : id,
      'amount' : amount,
      'rev_cost_id' : revenue.id,
      'tax' : tax,
      '_destroy': _destroy
    };
  }
    
  @override
  void loadWithJson(Map<String, dynamic> map) {
    this.revenue = loadRevenueByMap(map,'revenue');
    this.from = loadLocatinByMap(map, 'from'); 
    this.to = loadLocatinByMap(map, 'to'); 
    super.loadWithJson(map);
  }
  
  Location loadLocatinByMap(map,target){
     var aux;
     if(map[target] != null){
       aux = LoadModel.loadLocation(map[target]);
       map.remove(target);
     }
     return aux;
   }
  
  Revenue loadRevenueByMap(map,target){
     var aux;
     if(map[target] != null){
       aux = LoadModel.loadRevenue(map[target]);
       map.remove(target);
     }
     return aux;
   }

}
