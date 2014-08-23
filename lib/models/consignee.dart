part of transnode;

class Consignee extends RecordModelNested{

  String instructions;
  String readyDate;
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

  Map to_map() {
    print('to_map cons');
    return {
      'id' : id,
      'instructions' : instructions,
      'ready_date' : readyDate,
      'open_from': openFrom,
      'open_to': openTo,
      'appointment_date' : appointmentDate,
      'appointment_hour' : appointmentHour,
      'spec_handl' : specHandl,
      '_destroy' : _destroy
    };
  }
  
  void addNewLane(){
    this.lines.add(new Line());
  }
}
