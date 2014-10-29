part of transnode;

class InvoiceAP extends RecordModelNested{

  String status;
  Carrier vendor;
  DateTime dueDate;
  String currency;
  DateTime received_date;
  String createdAt;
  String updatedAt;
  bool acepted;
  String checkedStatus;
  
  List<InvoiceItemAP> items;
  var totalSelected;
  
  InvoiceAP(){
    acepted = null;
    status = 'New';
    items = [];
    totalSelected = 0;
    this._validator = new InvoiceApValidator(this);
  }
  
  setValidatorReview(){
    this._validator = new ReviewInvoiceApValidator(this);
  }
  
  receivedDateFormated() => DateHelper.formated(this.received_date);
  dueDateFormated() => DateHelper.formated(this.dueDate);
  
  @override
  void loadWithJson(Map<String, dynamic> map) {
    this.received_date = loadDate(map, 'received_date');
    this.dueDate = loadDate(map, 'due_date');
    this.vendor = loadCarrierByMap(map,'vendor');
    super.loadWithJson(map);
    loadItems(map);
  }

  static Carrier loadCarrierByMap(map,target){
     var aux;
     if(map[target] != null){
       aux = LoadModel.loadCarrier(map[target]);
       map.remove(target);
     }
     return aux;
   }
  
  checkApAmounts(){
    List itemsEquals = items.takeWhile((i) => i.amount.toString() == i.cost.amount.toString());
    this.setcheckedStatus(itemsEquals);
  }
  
  checkLogic(){
    items.forEach((i) =>i.checkEqual());
    if(inCheckedStatus("EQUAL")){
      this.status = StatusInvoice.READY_FOR_EXPORT.value;
    }
  }
  
  bool inCheckedStatus(String status){
    return status == this.checkedStatus;
  }

  setcheckedStatus(List equalsItems){
    if(equalsItems.length == items.length){
      this.checkedStatus = "EQUAL";
    }else if( equalsItems.length > 0 ){
      this.checkedStatus = "SOMENOTEQUAL";
    } if(equalsItems.length == 0){
      this.checkedStatus = "NOTEQUAL";
    }
  }
  
  void loadItems(Map map){
    if (map.containsKey("items_attributes")) {
      map['items_attributes'].forEach((attr) {
        this.items.add( LoadModel.loadInvoiceItemAP(attr) );
      });
    }
  }
  
  bool haveItemIsRejected() => items.contains((i)=>(!i.selected));
  
  void checkInvoiceIssue(){
    if(this.haveItemIsRejected()){
      this.status = StatusInvoice.ISSUE;
    }
  }

  Map to_map() {
    print('to_map invoice');
    return {
      'id' : id,
      'status' : status,      
      'carrier_id' : vendor.id,
      'due_date' : dueDate.toIso8601String(),
      'received_date': received_date.toIso8601String(),
      'currency' : currency,
      'items_attributes' : HelperList.to_map(items)
    };
  }
  
  void acepte(){
    this.acepted = true;
    this.status = StatusInvoice.READY_FOR_EXPORT.value;
  }
  
  void rejecte(){
    this.acepted = false;
    this.status = StatusInvoice.ISSUE.value;
  }
  
    
  loadDate(Map map, key){
    DateTime aux;
    if(map.containsKey(key)){
      aux = LoadModel.loadDateTime(map[key]);
      map.remove(key);      
    }
    return aux;
  }
  
  void selectedItemsLoaded(){
    this.items.forEach((i) => i.selected = true );
  }
  
  changeSelectedItems(){
    this.totalSelected = sumTotals();
  }
  
  sumTotals(){
   return selectedItems.fold(0.0,(p,e)=> p+ ParserNumber.toDouble(e.amount));
  }
  
  List get selectedItems => items.where((i) => i.selected);

}
