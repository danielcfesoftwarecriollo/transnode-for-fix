part of transnode;

class Quote extends RecordModel{

  Customer customer;
  int locationId;
  String fromCity;
  String fromZip;
  int fromCountry;
  String toCity;
  String toZip;
  int toCountry;
  String description;
  String custNote;
  String internalNote;
  String status;
  int rFQ_src;
  var rfq_date;
  double price;
  String dateValid;

  List<Line> lines;

  double _totalWeight;
  int _totalpcs;

  Quote(){
    this._validator = new QuoteValidator(this);
    this.lines = [new Line()];
  }


  List<Map> lines_to_map() {
    List<Map> lines_map = [];
    this.lines.forEach((line) => lines_map.add(line.to_map()));
    return lines_map;
  }
  
  Map to_map() {
    return {
      'id' : id,
      'entity_id' : customer, 
      'locationId' : locationId, 
      'from_city_id' : fromCity, 
      'from_zip' : fromZip, 
      'from_country_id' : fromCountry, 
      'to_city_id' :  toCity,
      'to_zip' : toZip, 
      'to_country_id' : toCountry, 
      'description' : description, 
      'customer_note' : custNote, 
      'intenal_note' : internalNote,

//      'status' : status, 
//      'rFQ_src' : rFQ_src, 
//      'rfq_date' : rfq_date, 
//      'price' : price, 
//      'dateValid' : dateValid,
      'quote_lines_attributes' : lines_to_map()
    };
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
   if (line.weight !=null && !line.weight.isNaN)
     _totalWeight += line.weight;
    
   if (line.num_pcs !=null &&!line.num_pcs.isNaN) 
     _totalpcs += line.num_pcs;
  }
  
}
