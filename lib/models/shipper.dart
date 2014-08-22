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

  Map to_map() {
    print('intro');
    return {
      'id' : id,
      'instructions'    : instructions,
      'ready_date'      : ready_date,
      'open_from'        : openFrom,
      'open_to'          : openTo,
      'appointment_date' : appointmentDate,
      'appointment_hour' : appointmentHour,
      'spec_handl'       : specHandl
      // 'lines_attributes' : linesToMap()
    };
  }

}
