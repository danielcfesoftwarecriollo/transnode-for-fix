part of transnode;

class Shipper extends RecordModelNested{

  String instructions;
  DateTime dateReady;
  DateTime openFrom;
  DateTime openTo;
  DateTime dateAppointment;
  DateTime appointmentHour;
  String specialHandling;
  String createdAt;
  String updatedAt;

  List<Line> lines;
  Location locationCustomer;
  Customer customer;

  Shipper(){
    this.lines = [];
    this._validator = new ShipmentShipperValidator(this);
  }

  void addNewLane(){
    this.lines.add(new Line());
  }

  bool full_valid(){
    bool result = _validator.run_validations();
    this.lines.forEach((l) => result = l.is_valid() && result);
    return result;
  }

  @override
  void loadWithJson(Map<String, dynamic> map) {
    LoadModel loadModel = new LoadModel();        
    this.dateReady = loadModel.loadDate(map, 'date_ready');
    this.openFrom = loadModel.loadDate(map, 'open_from');
    this.openTo = loadModel.loadDate(map, 'open_to');
    this.dateAppointment = loadModel.loadDate(map, 'date_appointment');
    this.appointmentHour = loadModel.loadDate(map, 'appointment_hour');        
        
    loadCustomerLocation(map);
    loadCustomer(map);
    super.loadWithJson(map);
    this._loadListObj(map);
  }
  
  void resetIdLists(){
    this.lines.forEach((l){
      l.id = null;
    });
  }
  
  loadCustomer( Map customerMap ){
    if(customerMap['customer'] != null){ 
      this.customer = LoadModel.loadCustomer(customerMap['customer']);
    }
    customerMap.remove('customer');
  }
  
  loadCustomerLocation( Map customerMap ){
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
  
  double totalWeight(){
    double _totalWeight = 0.0;
    lines.forEach((l){
      _totalWeight += double.parse(l.weight.toString());
    });
    return _totalWeight;
  }

  Map to_map() {
    print('to_map ship');
    return {
      'id' : id,
      'instructions'    : instructions,
      'date_ready'      : ParserDate.dateToString(dateReady),
      'open_from'        : ParserDate.dateToString(openFrom),
      'open_to'          : ParserDate.dateToString(openTo),
      'date_appointment' : ParserDate.dateToString(dateAppointment),
      'location_customer_id' : locationCustomer.id,
      'appointment_hour' : ParserDate.dateToString(appointmentHour),
      'special_handling' : specialHandling,
      'lines_attributes' : HelperList.to_map(lines),
      '_destroy': _destroy
    };
  }

}
