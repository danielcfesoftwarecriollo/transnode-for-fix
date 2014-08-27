part of transnode;

class Consignee extends RecordModelNested{

  String instructions;
  String openFrom;
  String openTo;
  String dateAppointment;
  String appointmentHour;
  String dateEta;
  String receivedBy;
  String dateReceived;
  String receivedHour; // not add to map
  String createdAt;
  String updatedAt;
  String on;
  Location locationCustomer;
  List<Line> lines;
  
  String consigneeName;
  Customer customer;
  
  Consignee(){
    this.lines = []; 
  }

  @override
  void loadWithJson(Map<String, dynamic> map) {
    loadCustomerLocation(map);
    super.loadWithJson(map);
  }

  loadCustomerLocation(Map customerMap ){
    if(customerMap['location_customer'] != null){
      Location l = new Location();
      l.loadWithJson(customerMap['location_customer']);  
      this.locationCustomer = l;
    }
    customerMap.remove('location_customer');
  }
  
  Map to_map() {
    print('to_map cons');
    return {
      'id' : id,
      'date_eta' : dateEta,
      'open_to': openTo,
      'open_from': openFrom,
      'received_by' : receivedBy,
      'instructions' : instructions,
      'date_received' : dateReceived,
      'date_appointment' : dateAppointment,
//      'appointment_hour' : appointmentHour,
      'location_customer' : locationCustomer,
      '_destroy' : _destroy
    };
  }
  
  void addNewLane(){
    this.lines.add(new Line());
  }
}
