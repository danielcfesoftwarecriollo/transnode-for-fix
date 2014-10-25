part of transnode;

@InjectableService()
class InvoiceAPService {
  static String url = '/carrier_invoices';
  UserService user;
  MessagesService _messageServices;
  ApiService _api;
  
  InvoiceAPService(this._api, this.user, this._messageServices);

  Future index() {
    return _api.request('get', url);
  }

  Future<InvoiceAP> getInvoice(String invoiceId) {
    return _api.request("get", url + "/review_invoice/${invoiceId.toString()}" )
      .then((HttpResponse response) => LoadModel.loadInvoiceAP(response.data));
  }
  
  Future<InvoiceAP> get(String invoiceId) {
    return _api.request("get", url + "/" + invoiceId.toString())
      .then((HttpResponse response) => LoadModel.loadInvoiceAP(response.data));
  }

  Future<InvoiceAP> delete(String invoiceId) {
    return _api.request("delete", url + "/" + invoiceId.toString())
      .then((_) => _messageServices.add("info", "Carrier Invoice delete it"));
  }
  
  Future<InvoiceAP> saveReview(InvoiceAP invoiceAP) {
    return _api.request("post", url + '/review_invoice/', data:params_update(invoiceAP))
          .then((HttpResponse response) => response.data);
  }
  
  Future save(InvoiceAP invoice) {
    String method, parameters, path;
    if (invoice.is_new()) {
      method = 'post';
      parameters = params(invoice);
      path = url;
    } else {
      method = 'put';
      parameters = params_update(invoice);
      path = url + "/" + invoice.id.toString() ; 
    }
    
    return _api.request(method, path, data: parameters)
      .catchError((HttpResponse response) {
        if (response.status == 422) {
          Map<String, List<String>> errors = JSON.decode(response.data);
          _messageServices.add("danger", "Review the errors in the form");
          invoice.set_errors(errors);
        }
      });
  }
  
  String params_update(InvoiceAP invoice) {
    return encode({
      "carrier_invoice": invoice.to_map(),
      "id": invoice.id
    });
  }
  String params(InvoiceAP invoice) {
    return encode({
      "carrier_invoice": invoice.to_map()
    });
  }
  String params_id(InvoiceAP invoice) {
    return encode({
      "id": invoice.id
    });
  }

  String encode(Map map) {
    return JSON.encode(map);
  }
}
