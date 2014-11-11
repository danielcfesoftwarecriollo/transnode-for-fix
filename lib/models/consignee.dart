part of transnode;

class Consignee extends RecordModelNested{

  String instructions;
  DateTime openFrom;
  DateTime openTo;
  DateTime dateAppointment;
  DateTime appointmentHour;
  DateTime dateEta;
  String receivedBy;
  DateTime dateReceived;
  DateTime receivedHour; // not add to map
  String createdAt;
  String updatedAt;
  DateTime on;
  Location locationCustomer;
  List<Line> lines;
  
  String consigneeName;
  Customer customer;
  
  Consignee(){
    this.lines = []; 
    this._validator = new ShipmentConsigneeValidator(this);
  }

  @override
  void loadWithJson(Map<String, dynamic> map) {
    LoadModel loadModel = new LoadModel();
    this.openFrom = loadModel.loadDate(map, 'open_from');
    this.openTo = loadModel.loadDate(map, 'open_to');
    this.dateEta = loadModel.loadDate(map, 'date_eta');
    this.dateAppointment = loadModel.loadDate(map, 'date_appointment');
    this.appointmentHour = loadModel.loadDate(map, 'appointment_hour');
    this.dateReceived = loadModel.loadDate(map, 'date_received');
    this.receivedHour = loadModel.loadDate(map, 'received_hour');
    this.on = loadModel.loadDate(map, 'on');    
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
  
  int idToSelect(){
    if(this.id == null || this.id.toString().isEmpty){
      return locationCustomer.id;
    }else{
      return id;
    }
  }
  
  Map to_map() {
    print('to_map cons');
    return {
      'id' : id,
      'date_eta' : ParserDate.dateToString(dateEta),
      'open_to': ParserDate.dateToString(openTo),
      'open_from': ParserDate.dateToString(openFrom),
      'received_by' : receivedBy,
      'instructions' : instructions,
      'date_received' : ParserDate.dateToString(dateReceived),
      'received_hour' : ParserDate.dateToString(receivedHour),
      'date_appointment' : ParserDate.dateToString(dateAppointment),
      'appointment_hour' : ParserDate.dateToString(appointmentHour),
      'location_customer_id' : locationCustomer.id,
      '_destroy' : _destroy
    };
  }
  
  void addNewLane(){
    this.lines.add(new Line());
  }
}
