part of transnode;

class Consignee extends RecordModelNested{

  String instructions;
  String ready_date;
  String openFrom;
  String openTo;
  String appointmentDate;
  String appointmentHour;
  String specHandl;

  String consigneeName;

  // String eta;
  // String receivedBy;
  // String receivedDate;
  // String receivedHour;

  Customer customer;
  Location locationCustomer;
  List<Line> lines;
  
  Consignee(){
    this.lines = []; 
  }
  
  void addNewLane(){
    this.lines.add(new Line());
  }
}
