part of transnode;

@InjectableService()
class PaymentService {
  static String url = '/payments';
  UserService user;
  MessagesService _messageServices;
  ApiService _api;

  PaymentService(this._api, this.user, this._messageServices);

  Future index() {
    return _api.request('get', url);
  }
  
  Future<Payment> get(String paymentId) {
    return _api.request("get", url + "/" + paymentId.toString())
      .then((HttpResponse response) => LoadModel.loadPayment(response.data));
  }

  Future save(Payment payment) {
    String method;
    String parameters;
    String path;
    if (payment.is_new()) {
      method = 'post';
      parameters = params(payment);
      path = url;
    } else {
      method = 'put';
      parameters = params_update(payment);
      path = url + "/" + payment.id.toString() ; 
    }
    return _api.request(method, path, data: parameters)
      .catchError((HttpResponse response) {
        if (response.status == 422) {
          Map<String, List<String>> errors = JSON.decode(response.data);
          _messageServices.add("danger", "Review the errors in the form");
          payment.set_errors(errors);
        }
      });
  }

  String params_update(Payment payment) {
    return encode({
      "payment": payment.to_map(),
      "id": payment.id
    });
  }
  String params(Payment payment) {
    return encode({
      "payment": payment.to_map()
    });
  }
  String params_id(Payment payment) {
    return encode({
      "id": payment.id
    });
  }

  String encode(Map map) {
    return JSON.encode(map);
  }
}
