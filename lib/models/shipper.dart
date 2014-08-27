part of transnode;

class Shipper extends RecordModelNested{

  String instructions;
  String dateReady;
  String openFrom;
  String openTo;
  String dateAppointment;
  String appointmentHour;
  String specialHandling;
  String createdAt;
  String updatedAt;

  List<Line> lines;
  Location locationCustomer;

  Shipper(){
    this.lines = [];
  }
  
  void addNewLane(){
    this.lines.add(new Line());
  }
  @override
  void loadWithJson(Map<String, dynamic> map) {
     super.loadWithJson(map);
     this._loadListObj(map);
  }
 
  _loadListObj(map){
    
    if (map.containsKey("lines_attributes")) {
      map['lines_attributes'].forEach((attr) {
        Line l = new Line();
        l.loadWithJson(attr);
        this.lines.add(l);
      });
    }
  }
  
  Map to_map() {
    print('to_map ship');
    return {
      'id' : id,
      'instructions'    : instructions,
      'date_ready'      : dateReady,
      'open_from'        : openFrom,
      'open_to'          : openTo,
      'date_appointment' : dateAppointment,
//      'appointment_hour' : appointmentHour,
      'special_handling' : specialHandling,
      'lines_attributes' : HelperList.to_map(lines),
      '_destroy': _destroy
    };
  }

}
