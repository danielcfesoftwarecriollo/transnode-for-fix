part of transnode;

class Invoice extends RecordModelNested{

  String status;
  Location billTo;
  Shipment shipment;
  String dueDate;
  String currency;
  String exportDate;
  String createdAt;
  String updatedAt;
  List<InvoiceItem> items;
  var totalSelected;
  
  Invoice(){
    status = 'New';
    items = [];
    totalSelected = 0;
//    this._validator = new InvoiceValidator(this);
  }
  
  @override
  void loadWithJson(Map<String, dynamic> map) {
    this.billTo = loadLocationByMap(map,'bill_to');
    super.loadWithJson(map);
    loadItems(map);
  }
  
  static loadLocationByMap(map,target){
     var aux;
     if(map[target] != null){
       aux = LoadModel.loadLocation(map[target]);
       map.remove(target);
     }
     return aux;
   }
  
  void loadItems(Map map){
    if (map.containsKey("items_attributes")) {
      map['items_attributes'].forEach((attr) {
        this.items.add( LoadModel.loadInvoiceItem(attr) );
      });
    }
  }
  
  changeSelectedItems(){
    this.totalSelected = sumTotals();
  }
  
  List get selectedItems => items.map((i) => i.selected); 
  
  sumTotals(){
   return selectedItems.fold(0.0,(p,e){ p+ ParserNumber.toDouble(e.amount);});
  }

}
