part of transnode;

class Quote extends RecordModel{

  Customer customer;
  int locationId;
  int entityId;
  int fromCityId;
  City fromCity;
  int fromZip;
  int fromCountryId;
  int toCityId;
  City toCity;
  int toZip;
  int toCountryId;
  String description;
  String customerNote;
  String internalNote;
  String status;
  var rfqSrc;
  DateTime rfqDate;
  double price;
  DateTime dateValid;
  String createdAt;
  String updatedAt;
  String currency;
  User user;
  String specialHandling;
  String typeHandling;

  List<Line> lines;
  List<QuoteCost> costs;

  double _totalWeight;
  int _totalpcs;

  Carrier vendor;
  Quote(){
    this._validator = new QuoteValidator(this);
    this.lines = [new Line()];
    this.costs = [];
    this.dateValid = DateHelper.addDate(30);
  }

  getVendor(){
    if(this.vendor == null){
      this.vendor = costs.first.vendor;
    }
    return this.vendor;
  }
  
  @override
  void loadWithJson(Map<String, dynamic> map) {
    LoadModel loadModel = new LoadModel();
    this.rfqDate = loadModel.loadDate(map, 'rfq_date');
    this.dateValid = loadModel.loadDate(map, 'date_valid');
    loadCustomer(map); 
    loadCityTo(map);
    loadCityFrom(map);
    super.loadWithJson(map);
    this.lines = [];      
    if (map.containsKey("lines_attributes")) {
      map['lines_attributes'].forEach((attr) {
        Line l = new Line();
        l.loadWithJson(attr);
        this.lines.add(l);
      });
    }
    loadCosts(map);
    this.checkTotal();
  }
  
  loadCosts(Map costsMap){    
    if (costsMap.containsKey("costs_attributes")) {
      costsMap['costs_attributes'].forEach((attr) {
        this.costs.add(LoadModel.loadQuoteCost(attr));
      });
    }
  }
  
  loadCityFrom(Map customerMap ){
    if(customerMap['from_city'] != null){
      this.fromCity = LoadModel.loadCity(customerMap['from_city']);
    }
    customerMap.remove('from_city');
  }  
  
  loadCityTo(Map customerMap ){
    if(customerMap['to_city'] != null){
      this.toCity = LoadModel.loadCity(customerMap['to_city']);
    }
    customerMap.remove('to_city');
  }
  
  
  loadCustomer(Map customerMap ){
    if(customerMap['customerHash'] != null){
      Customer customer = new Customer();
      customer.loadWithJson(customerMap['customerHash']);  
      this.customer = customer;
    }
    customerMap.remove('customerHash');
  }
  
  List<Map> costs_to_map() {
    List<Map> costs_map = [];
    this.costs.forEach((quoteCosts) => costs_map.add(quoteCosts.to_map()));
    return costs_map;
  }

  List<Map> lines_to_map() {
    List<Map> lines_map = [];
    this.lines.forEach((line) => lines_map.add(line.to_map()));
    return lines_map;
  }
  
  Map to_map() {    
    return {
      'id' : id,
      'entity_id' : _idObjNotNull(customer),
      'from_city_id' : fromCityId, 
      'from_zip' : fromZip, 
      'from_country_id' : fromCountryId, 
      'to_city_id' :  toCityId,
      'to_zip' : toZip, 
      'to_country_id' : toCountryId, 
      'description' : description, 
      'customer_note' : customerNote, 
      'internal_note' : internalNote,
      'rfq_src' : rfqSrc,
      'status' : status,
      'special_handling' : specialHandling,
      'type_handling' :typeHandling,
      'costs_attributes' : costs_to_map(),
      'rfq_date' : ParserDate.dateToString(rfqDate),
      'date_valid' : ParserDate.dateToString(dateValid),
      'quote_lines_attributes' : lines_to_map()
    };
  }

  void delete_QuoteCost(QuoteCost qc) {
    if (qc.is_new()) {
      costs.remove(qc);
    } else {
      qc.delete();
    }
  }
  
  _idObjNotNull( obj ){
    return (obj == null)? null:obj.id ;
  }

  void addNewLine(){
    Line l = new Line();
    this.lines.add(l);
  }

  double totalPrice(){
    double totalPrice = 0.0;
    costs.forEach((QuoteCost qc){
      if (qc.number !=null ){
        totalPrice += _toDouble(qc.number);
      }
    });
    return totalPrice;
  }
  
  totalWeight() => _totalWeight;
  int totalPcs() => _totalpcs;
  
  bool checkTotal(){
    _totalpcs = 0;
    _totalWeight = 0.0;
      this.lines.forEach((l){
        this._sumLine(l);
      });
      return true;
  }

  void _sumLine(Line line){
   if (line.weight !=null )
     _totalWeight += _toDouble(line.weight);
    
   if (line.numPcs !=null ) 
     _totalpcs += _toInt(line.numPcs);
  }
  
  double _toDouble(x){
    if(x is String){
      x = double.parse(x);
    }
    return x;
  }
  int _toInt(x){
    if(x is String){
      x = int.parse(x);
    }
    return x;
  }
  
}
