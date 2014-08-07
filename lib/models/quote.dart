part of transnode;

class Quote extends RecordModel{

  Customer customer;
  int locationId;
  int entityId;
  int fromCityId;
  int fromZip;
  int fromCountryId;
  int toCityId;
  int toZip;
  int toCountryId;
  String description;
  String customerNote;
  String internalNote;
  String status;
  int rFQ_src;
  var rfq_date;
  double price;
  String dateValid;
  String created_at;
  String updated_at;

  List<Line> lines;

  double _totalWeight;
  int _totalpcs;

  Quote(){
    this._validator = new QuoteValidator(this);
    this.lines = [new Line()];
  }

  @override
  void loadWithJson(Map<String, dynamic> map) {
    super.loadWithJson(map);
    this.lines = [];
    if (map.containsKey("lines_attributes")) {
      map['lines_attributes'].forEach((attr) {
        Line l = new Line();
        l.loadWithJson(attr);
        this.lines.add(l);
      });
    }
  }

  List<Map> lines_to_map() {
    List<Map> lines_map = [];
    this.lines.forEach((line) => lines_map.add(line.to_map()));
    return lines_map;
  }

  Map to_map() {
    return {
      'id' : id,
      'entity_id' : entityId, 
      'locationId' : locationId, 
      'from_city_id' : fromCityId, 
      'from_zip' : fromZip, 
      'from_country_id' : fromCountryId, 
      'to_city_id' :  toCityId,
      'to_zip' : toZip, 
      'to_country_id' : toCountryId, 
      'description' : description, 
      'customer_note' : customerNote, 
      'internal_note' : internalNote,

//      'status' : status, 
//      'rFQ_src' : rFQ_src, 
//      'rfq_date' : rfq_date, 
//      'price' : price, 
//      'dateValid' : dateValid,
      'quote_lines_attributes' : lines_to_map()
    };
  } 


  void addNewLine(){
    Line l = new Line();
    this.lines.add(l);
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
