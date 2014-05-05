part of transnode;

@NgInjectableService()
class ContactService {
  static String url = '/customers';
  UserService user;
  MessagesService _messageServices;
  ApiService _api;

  ContactService(this._api, this.user, this._messageServices);

  Future index() {
    return _api.request('get', url);
  }

  Future<Contact> get(String contactId) {
    return _api.request("get", url + "/" + contactId.toString())
      .then((HttpResponse response) => _loadContact(response.data));
  }

  Future save(Contact contact) {
    String method;
    String parameters;
    String path;
    if (contact.is_new()) {
      method = 'post';
      parameters = params(contact);
      path = url;
    } else {
      method = 'put';
      parameters = params_update(contact);
      path = url + "/" + contact.id.toString() ; 
    }
    return _api.request(method, path, data: parameters)
      .catchError((HttpResponse response) {
        if (response.status == 422) {
          Map<String, List<String>> errors = JSON.decode(response.data);
          _messageServices.add("danger", "Review the errors in the form");
          contact.set_errors(errors);
        }
      });
  }

  Contact _loadContact(map) {
    Contact contact = new Contact();
    contact.loadWithJson(map);
    return contact;
  }

  String params_update(Contact contact) {
    return encode({
      "customer": contact.to_map(),
      "id": contact.id
    });
  }
  String params(Contact contact) {
    return encode({
      "contact": contact.to_map()
    });
  }
  String params_id(Contact contact) {
    return encode({
      "id": contact.id
    });
  }

  String encode(Map map) {
    return JSON.encode(map);
  }
}
