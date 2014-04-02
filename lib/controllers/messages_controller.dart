library transnode.messages_controller;

import 'package:angular/angular.dart';
import 'package:transnode/services/messages_service.dart';

@NgController(selector: '[messages-controller]', publishAs: 'messages')
class MessagesController {
  MessagesService _message_service;

  MessagesController(this._message_service);

  bool get hasMessage => _message_service.hasMessage;
  List<String> get messages => _message_service.messages;
}
