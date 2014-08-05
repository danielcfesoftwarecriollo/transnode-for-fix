part of transnode;

class Quote extends RecordModel{

  Customer customer;
  int locationId;
  City fromCity;
  String fromZip;
  int fromCountry;
  City toCity;
  String toZip;
  int toCountry;
  String description;
  String cust_message;
  String status;
  int rFQ_src;
  var rfq_date;
  double price;
  String dateValid;

  List<Line> lines;

  double _totalWeight;
  int _totalpcs;

  Quote(){
//    this._validator = new QuoteValidator(this);
    this.lines = [new Line(),new Line()];
  }
  
  Map to_map() {
    return {
      'id' : id
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
