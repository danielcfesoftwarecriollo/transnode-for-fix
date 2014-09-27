part of transnode;

class Shipment extends RecordModel{
  int speed_rating;
  int quality_rating;
  int price_rating;
  String file_created;
  String credit_check;
  
// is needed save?
  bool multipleCarriers;
  
//Begin Values not use in view
//  String fileRef;
  String shipCons;
  String branchId;
  String status;
  String description;
  String typeShipment;
  String payStatus;
  String currency;
//End Values not use in view

  Customer customer;
  Location billto;
  Customer customBroker;
  double _totalWeight;
  int _totalpcs;
  Quote quote;


  List<Note> notes;
  List<Shipper> shippers;
  List<Consignee> consignees;
  List<ShipmentCarrier> carriers;
  List<RevenueCost> revCosts;

  Shipment() {
    status = 'new';
    speed_rating = 5;
    quality_rating = 5;
    price_rating = 5;
    _totalWeight = 0.0;
    _totalpcs = 0;
    shippers = [];
    consignees = [];
    carriers = [];
    revCosts = [];
    notes = [];
    multipleCarriers = true;
    this._validator = new ShipmentValidator(this);
  }
  
  // extract in another model
  
  loadShipmentWithQuote(Quote q){
    this.quote = q;
    this.customer = q.customer;
    
    if(q.costs.isNotEmpty){
      ShipmentCarrier sc = new ShipmentCarrier();
      sc.carrier = q.costs.first.vendor;
      this.carriers.add(sc);
    }    
    
    Shipper shipper = new Shipper();
    if(q.customer.locations.isNotEmpty){
      shipper.locationCustomer = q.customer.locations.first;
    }
    shipper.lines.addAll(q.lines);
    shipper.resetIdLists();
    this.shippers.add(shipper);

    this.revCosts = loadRevenuCostsWithQuoteCost(q.costs);
  }
  
  List<RevenueCost> loadRevenuCostsWithQuoteCost(List costs){
    List<RevenueCost> listRevCost = [];
    costs.forEach((QuoteCost qc){
      RevenueCost rc = new RevenueCost();
      rc.vendor = qc.vendor;
      rc.amount = qc.number;
      rc.billTo = this.customer.billTo;
      rc.currency = this.customer.currency;
      listRevCost.add(rc);
    });
    return listRevCost;
  }
  // extract in another model
  
  void addRevenueCost(){
    RevenueCost revCost = new RevenueCost();
    this.revCosts.add(revCost);
  }

  void addLineToConsignee(Line line){
    Consignee consignee = this.consignees.firstWhere((e)=> e.locationCustomer.id == line.consigneeId);
      if(consignee != null){
        consignee.lines.add(line);
        checkTotal();
      }
  }

  bool valid_step1() {
    bool result = _validator.run_validations_step1();
    this.shippers.forEach((s) => result = s.full_valid() && result);
    return result;
  }
  
  bool valid_step2(){    
    return _validator.run_validations_step2();
  }
  
  void delete_consignee(Consignee consignee) {
    if (consignee.is_new()) {
      consignees.remove(consignee);
      consignee.lines.remove(consignee.locationCustomer);
    } else {
      consignee.delete();
    }
  }

  void delete_shipper(Shipper shipper) {
    if (shipper.is_new()) {
      shippers.remove(shipper);
      shipper.lines.remove(shipper.locationCustomer);
    } else {
      shipper.delete();
    }
  }
  
  void deleteRCLine(RevenueCost rc) {
    if (rc.is_new()) {
      revCosts.remove(rc);
    } else {
      rc.delete();
    }
  }

  void delete_carrier(ShipmentCarrier sc) {
   if (sc.is_new()) {
     carriers.remove(sc);
   } else {
     sc.delete();
   }
  }
   
   @override
   void loadWithJson(Map<String, dynamic> map) {
      super.loadWithJson(map);
      this._loadListObj(map);
      this.loadLinesConsignee();
   }
  
   
  _loadListObj(map){
    loadCustomer(map);
    loadBillto(map);
    loadCustomBroker(map);
    
    if (map.containsKey("shippers_attributes")) {
      map['shippers_attributes'].forEach((attr) {
        Shipper s = new Shipper();
        s.loadWithJson(attr);
        this.shippers.add(s);
      });
    }

    if (map.containsKey("consignees_attributes")) {
      map['consignees_attributes'].forEach((attr) {
        Consignee s = new Consignee();
        s.loadWithJson(attr);
        this.consignees.add(s);
      });
    }
    
    if (map.containsKey("notes_attributes")) {
      map['notes_attributes'].forEach((attr) {
        Note s = new Note();
        s.loadWithJson(attr);
        this.notes.add(s);
      });
    }

    if (map.containsKey("carriers_attributes")) {
      map['carriers_attributes'].forEach((attr) {
        ShipmentCarrier s = new ShipmentCarrier();
        s.loadWithJson(attr);
        this.carriers.add(s);
      });
    }

    if (map.containsKey("revenue_costs_attributes")) {
      map['revenue_costs_attributes'].forEach((attr) {
        RevenueCost s = new RevenueCost();
        s.loadWithJson(attr);
        this.revCosts.add(s);
      });
    }
    
  }

  loadCustomer(Map customerMap ){
    if(customerMap['customer'] != null){
      this.customer = LoadModel.loadCustomer(customerMap['customer']);
    }
    customerMap.remove('customer');
  }
  
  loadBillto(Map customerMap ){
    if(customerMap['billto'] != null){
      Location l = new Location();
      l.loadWithJson(customerMap['billto']['location']);  
      this.billto = l;
    }
    customerMap.remove('billto');
  }
    
  loadCustomBroker(Map customerMap ){
    if(customerMap['custom_broker'] != null){
      this.customBroker = LoadModel.loadCustomer(customerMap['custom_broker']);
    }
    customerMap.remove('custom_broker');
  }
   
    
  Map to_map() {
    print('intro');
    
    return {
      'id' : id,
      'customer_id'     : customer.id,
      'billto_id'       : billto.id,
      'custom_broker_id' : customBroker.id,
//      'file_created'   : file_created,
//      'credit_check'   : credit_check,
//      'multipleCarriers' : multipleCarriers,
//      'speed_rating'   : speed_rating,
//      'quality_rating' : quality_rating,
//      'price_rating'   : price_rating,
       'quote' : quote.id,
       'notes_attributes'      : HelperList.to_map(notes),
       'shippers_attributes'   : HelperList.to_map(shippers),
       'consignees_attributes' : HelperList.to_map(consignees),
       'carriers_attributes'   : HelperList.to_map(carriers),
       'revenue_costs_attributes': HelperList.to_map(revCosts)

    };
  }
  
  void loadLinesConsignee(){
    shippers.forEach((s){
      s.lines.forEach((l){
        addLineToConsignee(l);
      });
    });
  }

  totalWeight() => _totalWeight;
  int totalPcs() => _totalpcs;
  
  void checkTotal(){
    _totalpcs = 0;
    _totalWeight = 0.0;
    consignees.forEach((e){
      e.lines.forEach((l){
        this._sumLine(l);
      });
    });
  }

  void _sumLine(Line line){
    _totalWeight += double.parse(line.weight.toString());
    _totalpcs += double.parse(line.numPcs.toString());
  }
  

}
