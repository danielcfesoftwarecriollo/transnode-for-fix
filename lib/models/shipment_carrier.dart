part of transnode;

class ShipmentCarrier extends RecordModelNested{

  String equipment;
  String service;
  String booked;
  String insureAmt;
  String other;

  Carrier carrier;

  var helperInput;
  
  ShipmentCarrier(){
    this._validator = new ShipmentCarrierValidator(this);
  }
  
  @override
  void loadWithJson(Map<String, dynamic> map) {
     super.loadWithJson(map);
     this.loadCarrier(map);
  }

   void loadCarrier(Map customerMap ){
      if(customerMap['carrier'] != null){
        Carrier carrier = new Carrier();
        carrier.loadWithJson(customerMap['carrier']);  
        this.carrier = carrier;
      }
      customerMap.remove('carrier');
    }
  
  Map to_map() {
    print('to map shipmentCarrier');
    var carrierId = (carrier == null)? null: carrier.id;
    return {
      'id' : id,
       'equipment'  : equipment,
       'service'    : service,
       'booked'     : booked,
       'insure_amt' : insureAmt,
       'other'      : other,
       'carrier_id' : carrierId,
       '_destroy': _destroy
    };
  }
}
