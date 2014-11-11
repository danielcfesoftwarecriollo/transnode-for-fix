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

  static  loadRating(Map<String, dynamic> json) {
    Rating r = new Rating(Rating.PRICE);
    r.loadWithJson(json);
    return r;
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
  
  static loadExchangeRateFactor(Map<String, dynamic> json) {
    ExchangeRateFactor er = new ExchangeRateFactor();
    er.loadWithJson(json);
    return er;
  }
  
  static loadExchangeRateFactors(List listMap) {
    List<ExchangeRateFactor> aux = [];
    listMap.forEach((er){
      aux.add(loadExchangeRateFactor(er));
    });
    return aux;
  }
  
  static loadLocation(Map<String, dynamic> json) {
    Location l = new Location();
    l.loadWithJson(json);
    return l;
  }
  
  static loadCost(Map<String, dynamic> json) {
    Cost q = new Cost();
    q.loadWithJson(json);
    return q;
  }
  
  static loadRevenue(Map<String, dynamic> json) {
    Revenue q = new Revenue();
    q.loadWithJson(json);
    return q;
  }

  static Note loadNote(Map<String, dynamic> json) {
    Note n = new Note();
    n.loadWithJson(json);
    return n;
  }

  static Contact loadContact(Map<String, dynamic> json) {
    Contact c = new Contact();
    c.loadWithJson(json);
    return c;
  }
  
  static User loadUser(Map<String, dynamic> json) {
    User u = new User();
    u.loadWithJson(json);
    return u;
  }

  static Invoice loadInvoice(Map<String, dynamic> json) {
    Invoice i = new Invoice();
    i.loadWithJson(json);
    return i;
  }
  
  static InvoiceAP loadInvoiceAP(Map<String, dynamic> json) {
    InvoiceAP i = new InvoiceAP();
      i.loadWithJson(json);
      return i;
    }  
  
  static InvoiceItem loadInvoiceItem(Map<String, dynamic> json) {
    InvoiceItem i = new InvoiceItem();
    i.loadWithJson(json);
    return i;
  }
  
  static InvoiceItemAP loadInvoiceItemAP(Map<String, dynamic> json) {
    InvoiceItemAP i = new InvoiceItemAP();
    i.loadWithJson(json);
    return i;
  }
  
  static DateTime loadDateTime( String date ){
    if(date != null){
      return DateTime.parse( date );
    }
    return null;
  }
  
  static Payment loadPayment(Map<String, dynamic> json) {
    Payment p = new Payment();
    p.loadWithJson(json);
    return p;
  }
  
  static PaymentInvoice loadPaymentInvoice(Map<String, dynamic> json) {
    PaymentInvoice p = new PaymentInvoice();
    p.loadWithJson(json);
    return p;
  }

  DateTime loadDate(Map map, key){
    DateTime aux;
    if(map.containsKey(key)){
      aux = loadDateTime(map[key]);
      map.remove(key);
    }
    return aux;
  }


}
