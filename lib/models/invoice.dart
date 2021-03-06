part of transnode;

class Invoice extends RecordModelNested{

  String status;
  Location billTo;
  Shipment shipment;
  DateTime dueDate;
  String currency;
  DateTime exportDate;
  String createdAt;
  String updatedAt;
  List<InvoiceItem> items;
  var totalSelected;
  String total;
  String balance;
  
  Invoice(){
    status = 'New';
    items = [];
    totalSelected = 0;
    balance = '0';
    this._validator = new InvoiceValidator(this);
  }
  
  exportDateFormated() => DateHelper.formated(this.exportDate);
  dueDateFormated() => DateHelper.formated(this.dueDate);
  
  @override
  void loadWithJson(Map<String, dynamic> map) {
    this.exportDate = loadDate(map, 'export_date');
    this.dueDate = loadDate(map, 'due_date');
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
  
  Map to_map() {
    print('to_map invoice');
    return {
      'id' : id,
      'status' : status,
      'bill_to_id' : billTo.id,
      'due_date' : dueDate.toIso8601String(),
      'export_date': exportDate.toIso8601String(),
      'currency' : currency,
      'items_attributes' : HelperList.to_map(items)
    };
  }
  
  loadDate(Map map, key){
    DateTime aux;
    if(map.containsKey(key)){
      aux = LoadModel.loadDateTime(map[key]);
      map.remove(key);      
    }
    return aux;
  }

  bool inStatus(String statusTo){
    return (this.status.toString() == statusTo.toString());
  }
  
  void selectedItemsLoaded(){
    this.items.forEach((i) => i.selected = true );
  }
  
  changeSelectedItems(){
    this.totalSelected = sumTotals();
  }
  
  List get selectedItems => items.where((i) => i.selected); 
  
  sumTotals(){
   return selectedItems.fold(0.0,(p,e)=> p+ ParserNumber.toDouble(e.amount));
  }

}
