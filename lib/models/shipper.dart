part of transnode;

class Shipper extends RecordModelNested{

  String instructions;
  String ready_date;
  String openFrom;
  String openTo;
  String appointmentDate;
  String appointmentHour;
  String specHandl;

  List<Line> lines;
  Location locationCustomer;

  Shipper(){
    this.lines = [new Line()]; 
  }
  
  void addNewLane(){
    this.lines.add(new Line());
  }
}
