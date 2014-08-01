part of transnode;

class Shipment extends RecordModel{
  int speed_rating;
  int quality_rating;
  int price_rating;
  String file_created;
  String credit_check;
  int customerId;
  int billToId;
  int customsbrokerId;
  bool multipleCarriers;


  Customer customer;
  Location billto;
  Customer customsbroker;
  double _totalWeight;
  int _totalpcs;

  List<Note> notes;
  List<Shipper> shippers;
  List<Consignee> consignees;
  List<ShipmentCarrier> carriers;

  void loadCustomer(Customer customer){
    this.customer = customer;
    this.customerId = customer.id;
  }

  void loadBillTo(Location billto){
    this.billto = billto;
    this.billToId = billto.id;
  }

  void loadCustomsbroker(Customer customsbroker){
    this.customsbroker = customsbroker;
    this.customsbrokerId = customsbroker.id;
  }

  Shipment() {
    speed_rating = 1;
    quality_rating = 1;
    price_rating = 1;
    _totalWeight = 0.0;
    _totalpcs = 0;
    shippers = [];
    consignees = [];
    carriers = [];
    Note note = new Note();
    note.dateCreated = '22/22/2014';
    note.author = 'Daniel Castillo';
    note.description = """Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.""";
    notes = [note];
  }

  void addLineToConsignee(Line line){
    Consignee consignee = this.consignees.firstWhere((e)=> e.locationCustomer.id == line.consigneId);
      if(consignee != null){
        consignee.lines.add(line);
        checkTotal();
      }
  }

  void delete_consignee(Consignee consignee) {
    if (consignee.is_new()) {
      consignees.remove(consignee);
      consignee.lines.remove(consignee.locationCustomer);
    } else {
      consignee.delete();
    }
  }

  void delete_shipper(Shipper shipper) {
    if (shipper.is_new()) {
      shippers.remove(shipper);
      shipper.lines.remove(shipper.locationCustomer);
    } else {
      shipper.delete();
    }
  }

   void delete_carrier(ShipmentCarrier sc) {
     if (sc.is_new()) {
       carriers.remove(sc);
     } else {
       sc.delete();
     }
   }

  Map to_map() {
    return {
      'id' : id,
      'speed_rating'   : speed_rating,
      'quality_rating' : quality_rating,
      'price_rating'   : price_rating
    };
  }

  totalWeight() => _totalWeight;
  int totalPcs() => _totalpcs;
  
  void checkTotal(){
    _totalpcs = 0;
    _totalWeight = 0.0;
    consignees.forEach((e){
      e.lines.forEach((l){
        this._sumLine(l);
      });
    });
  }

  void _sumLine(Line line){
    _totalWeight += line.weight;
    _totalpcs += line.num_pcs;
  }

}
