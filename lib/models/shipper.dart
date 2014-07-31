part of transnode;

class Shipper extends RecordModelNested{
  String code;
  String name;
  String city;
  String state;
  String csr_rep;
  String term;
  String custom_broker;
  String ready_date;
  List<Line> lines;
  Location locationCustomer;

  List locationsCustomer;

  Shipper(){
    this.lines = [new Line()]; 
  }
  
  void addNewLane(){
    this.lines.add(new Line());
  }
}
