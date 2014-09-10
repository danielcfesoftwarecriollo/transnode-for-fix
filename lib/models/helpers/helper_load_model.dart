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
}