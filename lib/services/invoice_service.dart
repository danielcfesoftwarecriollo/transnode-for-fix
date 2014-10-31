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

  Future<Invoice> getInvoice(String billToId) {
    return _api.request("get", url + "/consolidated_invoice/${billToId.toString()}" )
      .then((HttpResponse response) => LoadModel.loadInvoice(response.data));
  }

  Future<Invoice> getCreditNote(String carrierId) {
    return _api.request("get", url + "/consolidated_note_credit/${carrierId.toString()}" )
      .then((HttpResponse response) => LoadModel.loadInvoice(response.data));
  }
  
  Future<Customer> get(String customerId) {
    return _api.request("get", url + "/" + customerId.toString())
      .then((HttpResponse response) => LoadModel.loadInvoice(response.data));
  }

  Future<Customer> delete(String customerId) {
    return _api.request("delete", url + "/" + customerId.toString())
      .then((_) => _messageServices.add("info", "customer delete it"));
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
