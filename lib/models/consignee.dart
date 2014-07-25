part of transnode;

class Consignee extends RecordModel{
  String code;
  String openFrom;
  String openTo;
  String instructions;
  String eta;
  String appointmentDate;
  String appointmentHour;
  String receivedBy;
  String receivedDate;
  String receivedHour;
  List<Line> lines;
  
  Consignee(){
    this.lines = [new Line()]; 
  }
  
  void addNewLane(){
    this.lines.add(new Line());
  }
}
