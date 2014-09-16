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

  static loadCustomer(Map<String, dynamic> json) {
    Customer c = new Customer();
    c.loadWithJson(json);
    return c;
  }
  
  static loadCity(Map<String, dynamic> json) {
    City c = new City();
    c.loadWithJson(json);
    return c;
  }
  
  static loadQuote(Map<String, dynamic> json) {
    Quote q = new Quote();
    q.loadWithJson(json);
    return q;
  }
  
  static loadQuoteCost(Map<String, dynamic> json) {
    QuoteCost q = new QuoteCost();
    q.loadWithJson(json);
    return q;
  }
}