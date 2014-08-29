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
    this._validator = new ShipmentShipperValidator(this);
  }
  
  void addNewLane(){
    this.lines.add(new Line());
  }
  
  @override
  void loadWithJson(Map<String, dynamic> map) {
   loadCustomerLocation(map);
   super.loadWithJson(map);
   this._loadListObj(map);
  }

  loadCustomerLocation(Map customerMap ){
    if(customerMap['location_customer'] != null){
      Location l = new Location();
      l.loadWithJson(customerMap['location_customer']);  
      this.locationCustomer = l;
    }
    customerMap.remove('location_customer');
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
      'location_customer_id' : locationCustomer.id,
//      'appointment_hour' : appointmentHour,
      'special_handling' : specialHandling,
      'lines_attributes' : HelperList.to_map(lines),
      '_destroy': _destroy
    };
  }

}
