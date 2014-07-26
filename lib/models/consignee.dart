part of transnode;

class Consignee extends RecordModel{
  int id;
  String consigneeName;
  String openFrom;
  String openTo;
  String instructions;
  String eta;
  String appointmentDate;
  String appointmentHour;
  String receivedBy;
  String receivedDate;
  String receivedHour;
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
