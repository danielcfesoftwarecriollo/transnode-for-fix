part of transnode;

class LoadModel{
  
  static  loadCarrier(Map<String, dynamic> json) {
    Carrier carrier = new Carrier();
    carrier.loadWithJson(json);
    return carrier;
  }
  
  static  loadPrice(Map<String, dynamic> json) {
    Price p = new Price();
    p.loadWithJson(json);
    return p;
  }

  static  loadLane(Map<String, dynamic> json) {
    Lane l = new Lane();
    l.loadWithJson(json);
    return l;
  }
  
  static  loadShipment(Map<String, dynamic> json) {
    Shipment s = new Shipment();
    s.loadWithJson(json);
    return s;
  }
}