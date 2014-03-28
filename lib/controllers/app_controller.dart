library transnode.app_controller;

import 'package:angular/angular.dart';
import 'package:transnode/services/api_service.dart';
import 'package:transnode/services/message_service.dart' show MessageService;

@NgController(
    selector: '[transnode]',
    publishAs: 'app')
class AppController {
  ApiService _api;
  MessageService message;
  
  AppController(this._api,this.message);

  bool isAuthenticated() {
    return _api.isAuthenticated();
  }
  bool has_message(){
    return message.has_message();
  }
  String mesage_error(){
    return message.message;
  }

  String user_email() {
    return _api.user.email;
  }
}
