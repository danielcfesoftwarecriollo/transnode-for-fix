part of transnode;

class InvoiceItemAP extends RecordModelNested{

  String status;
  String createdAt;
  String updatedAt;
  double amount;
  double tax;
  Cost cost;
  String fileRef;
  String shipmentDateCreated;
  String docs;
  String numPcs;
  String weight;
  String statusShipment;
  Location from;
  Location to;
  bool acepted;
  
  bool selected;
    
  InvoiceItemAP(){
    status = 'New';
    selected = false;
//    this._validator = new InvoiceValidator(this);
  }
  
  void acepte(){
    this.acepted = true;
  }
  
  void rejecte(){
    this.acepted = false;
  }
  
  Map to_map() {
    print('to_map invoice_item');
    return {
      'id' : id,
      'amount' : amount,
      'rev_cost_id' : cost.id,
      'tax' : tax,
      'acepted' : acepted,
      '_destroy': _destroy
    };
  }
    
  @override
  void loadWithJson(Map<String, dynamic> map) {
    this.cost = loadCostByMap(map,'cost');
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
  
  Cost loadCostByMap(map,target){
     var aux;
     if(map[target] != null){
       aux = LoadModel.loadCost(map[target]);
       map.remove(target);
     }
     return aux;
   }
  

}
