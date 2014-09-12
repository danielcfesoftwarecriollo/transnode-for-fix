part of transnode;

@InjectableService()
class MailService {
  static String url = 'mails/';
  UserService user;
  MessagesService _messageServices;
  ApiService _api;

  MailService(this._api, this.user, this._messageServices);

  Future send_mail(Mail mail) {
    return _api.request("post", url + "send_mail_customer", data:params(mail) )
           .then((_) => _ );
  }

  String params(Mail mail) {
    return encode(mail.to_map());
  } 

  String encode(Map map) {
    return JSON.encode(map);
  }
}
