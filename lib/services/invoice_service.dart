part of transnode;

@InjectableService()
class InvoiceService {
  static String url = '/customer_invoices';
  UserService user;
  MessagesService _messageServices;
  ApiService _api;
  Map countriesx;

  InvoiceService(this._api, this.user, this._messageServices);

  Future index() {
    return _api.request('get', url);
  }

  Future getInvoicesByBillTo(String billToId, filters) {
    return _api.request("get", url + "/by_bill_to/${billToId.toString()}/${filters['status']}" )
      .then((HttpResponse response) => response.data);
  }
  
  Future<Invoice> getInvoice(String billToId) {
    return _api.request("get", url + "/consolidated_invoice/${billToId.toString()}" )
      .then((HttpResponse response) => LoadModel.loadInvoice(response.data));
  }

  Future<Invoice> getCreditNote(String carrierId) {
    return _api.request("get", url + "/consolidated_note_credit/${carrierId.toString()}" )
      .then((HttpResponse response) => LoadModel.loadInvoice(response.data));
  }
  
  Future<Invoice> get(String invoiceId) {
    return _api.request("get", url + "/" + invoiceId)
      .then((HttpResponse response) => LoadModel.loadInvoice(response.data));
  }

  Future cancel(String invoiceId) {
    return _api.request("post", url + "/cancel/"+invoiceId)
      .then((HttpResponse response) => response.data);
  }

  Future reOpen(String invoiceId) {
    return _api.request("post", url + "/reopen/"+invoiceId)
      .then((HttpResponse response) => response.data);
  }
  
  Future save(Invoice invoice) {
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

  String params_update(Invoice invoice) {
    return encode({
      "customer_invoice": invoice.to_map(),
      "id": invoice.id
    });
  }
  String params(Invoice invoice) {
    return encode({
      "customer_invoice": invoice.to_map()
    });
  }
  String params_id(Invoice invoice) {
    return encode({
      "id": invoice.id
    });
  }

  String encode(Map map) {
    return JSON.encode(map);
  }
}
